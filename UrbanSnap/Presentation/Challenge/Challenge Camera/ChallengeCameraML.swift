/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Contains the object recognition view controller for the Breakfast Finder.
*/

import UIKit
import AVFoundation
import Vision

extension ChallengeCameraScene {
   
    func setupAROutput(){
        
        setupOutput()
        
        let captureConnection = videoOutput.connection(with: .video)
        // Always process the frames
        captureConnection?.isEnabled = true
        do {
            if backCameraOn {
                try backCamera!.lockForConfiguration()
                let dimensions = CMVideoFormatDescriptionGetDimensions((backCamera?.activeFormat.formatDescription)!)                
                bufferSize.width = CGFloat(dimensions.width)
                bufferSize.height = CGFloat(dimensions.height)
                backCamera!.unlockForConfiguration()
            } else {
                try frontCamera!.lockForConfiguration()
                let dimensions = CMVideoFormatDescriptionGetDimensions((frontCamera?.activeFormat.formatDescription)!)
                bufferSize.width = CGFloat(dimensions.width)
                bufferSize.height = CGFloat(dimensions.height)
                frontCamera!.unlockForConfiguration()
            }
        } catch {
            print(error)
        }
        
    }
    
    
    @discardableResult
    func setupVision() -> NSError? {
        // Setup Vision parts
        let error: NSError! = nil
        
        guard let modelURL = Bundle.main.url(forResource: "ObjectDetector", withExtension: "mlmodelc") else {
            return NSError(domain: "ChallengeCameraScene", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model file is missing"])
        }
        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL))
            let objectRecognition = VNCoreMLRequest(model: visionModel, completionHandler: { (request, error) in
                DispatchQueue.main.async(execute: {
                    // perform all the UI updates on the main queue
                    if let results = request.results {
                        self.drawVisionRequestResults(results)
                    }
                })
            })
            self.requests = [objectRecognition]
        } catch let error as NSError {
            print("Model loading went wrong: \(error)")
        }
        
        return error
    }
    
    func drawVisionRequestResults(_ results: [Any]) {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        
        if detectionOverlay.sublayers?.isEmpty == false {
            detectionOverlay.sublayers = nil // remove all the old recognized objects
        }
        for observation in results where observation is VNRecognizedObjectObservation {
            guard let objectObservation = observation as? VNRecognizedObjectObservation else {
                continue
            }
            
            // Select only the label with the highest confidence.
            let topLabelObservation = objectObservation.labels[0]
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(bufferSize.width), Int(bufferSize.height))
            
            let shapeLayer = self.createRoundedRectLayerWithBounds(objectBounds)
            
            let textLayer = self.createTextSubLayerInBounds(objectBounds,
                                                            identifier: topLabelObservation.identifier,
                                                            confidence: topLabelObservation.confidence)
            
//            print("RESULT topLabelObservation \(topLabelObservation)")

            let recoginzeData = objectObservation.labels.filter {$0.confidence > 0.01}.map {$0.identifier}
            
            recoginzeData.forEach { data in
                if let row = challengeObjectData.firstIndex(where: {$0.title == data}) {
                    challengeObjectData[row].isSatisfy = true
//                    print("CURRENT ROW \(row)")
//                    print("CURRENT ROW \(challengeCameraView?.objectStacView.arrangedSubviews[0])")
//                    print("DETECTED LABEK \(challengeCameraView?.objectStacView.subviews[row])")
                    challengeCameraView?.objectStacView.arrangedSubviews[row].backgroundColor = .systemGreen
                } else {
                    challengeObjectData.forEach {
                        var data = $0
                        data.isSatisfy = false
                    }
                    
                    challengeCameraView?.objectStacView.arrangedSubviews.forEach({ view in
                        view.backgroundColor = .systemRed
                    })
                    

                }
            }
            
            self.canTakePicture = challengeObjectData.allSatisfy {$0.isSatisfy == true}
            self.challengeCameraView?.updateCameraButton()

            print("challengeObjectData DATA \(challengeObjectData)")
            print("recogineData DATA \(recoginzeData)")
            
//            if let array = challengeData?.challengeObject?.allObjects as? [ChallengeObjects] {
//
//
//
//            }
            
            shapeLayer.addSublayer(textLayer)
            detectionOverlay.addSublayer(shapeLayer)
        }
        self.updateLayerGeometry()
        CATransaction.commit()
    }
    
    
    public func exifOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
        let curDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: CGImagePropertyOrientation
        
        switch curDeviceOrientation {
        case UIDeviceOrientation.portraitUpsideDown:  // Device oriented vertically, home button on the top
            exifOrientation = .left
        case UIDeviceOrientation.landscapeLeft:       // Device oriented horizontally, home button on the right
            exifOrientation = .upMirrored
        case UIDeviceOrientation.landscapeRight:      // Device oriented horizontally, home button on the left
            exifOrientation = .down
        case UIDeviceOrientation.portrait:            // Device oriented vertically, home button on the bottom
            exifOrientation = .up
        default:
            exifOrientation = .up
        }
        return exifOrientation
    }
    func setupLayers() {
        detectionOverlay = CALayer() // container layer that has all the renderings of the observations
        detectionOverlay.name = "DetectionOverlay"
        detectionOverlay.bounds = CGRect(x: 0.0,
                                         y: 0.0,
                                         width: bufferSize.width,
                                         height: bufferSize.height)
        detectionOverlay.position = CGPoint(x: view.layer.bounds.midX, y: view.layer.bounds.midY)
        
        print("BUFFER SIZE \(bufferSize)")
        view.layer.addSublayer(detectionOverlay)
    }
    
    func updateLayerGeometry() {
        let bounds = view.layer.bounds
        var scale: CGFloat
        
        let xScale: CGFloat = bounds.size.width / bufferSize.height
        let yScale: CGFloat = bounds.size.height / bufferSize.width
        
        scale = fmax(xScale, yScale)
        if scale.isInfinite {
            scale = 1.0
        }
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        
        // rotate the layer into screen orientation and scale and mirror
        detectionOverlay.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: scale, y: -scale))
        // center the layer
        detectionOverlay.position = CGPoint(x: bounds.midX, y: bounds.midY)
        
        CATransaction.commit()
        
    }
    
    func createTextSubLayerInBounds(_ bounds: CGRect, identifier: String, confidence: VNConfidence) -> CATextLayer {
        let textLayer = CATextLayer()
        textLayer.name = "Object Label"
        let formattedString = NSMutableAttributedString(string: String(format: "\(identifier)\nConfidence:  %.2f", confidence))
        let largeFont = UIFont(name: "Helvetica", size: 24.0)!
        formattedString.addAttributes([NSAttributedString.Key.font: largeFont], range: NSRange(location: 0, length: identifier.count))
        textLayer.string = formattedString
        textLayer.bounds = CGRect(x: 0, y: 0, width: bounds.size.height - 10, height: bounds.size.width - 10)
        textLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        textLayer.shadowOpacity = 0.7
        textLayer.shadowOffset = CGSize(width: 2, height: 2)
        textLayer.foregroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.0, 0.0, 0.0, 1.0])
        textLayer.contentsScale = 2.0 // retina rendering
        // rotate the layer into screen orientation and scale and mirror
        textLayer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: 1.0, y: -1.0))
        return textLayer
    }
    
    func createRoundedRectLayerWithBounds(_ bounds: CGRect) -> CALayer {
        let shapeLayer = CALayer()
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        shapeLayer.name = "Found Object"
        shapeLayer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 0.2, 0.4])
        shapeLayer.cornerRadius = 7
        return shapeLayer
    }
    
}
