//
//  ChallengeCameraView.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 10/06/21.
//

import Foundation
import UIKit
import AVFoundation

extension ChallengeCameraScene {
    
    func setupView(){
      
        // loop
        //        let obj = objectLabel
        if let objectsData = challengeData?.challengeObject?.allObjects as? [ChallengeObjects] {
            
            let objectData = objectsData.map {$0.title ?? ""}
            
            objectData.forEach { data in
                challengeObjectData.append(ChallengeObjectData.init(title: data, isSatisfy: false))
            }
            
            objectsData.forEach { data in
                let label = PaddingLabel()
                label.textColor = .white
                //                label.text = "Building"
                label.font = UIFont.systemFont(ofSize: 14)
                label.backgroundColor = .systemRed
                label.paddingLeft = 32
                label.textAlignment = .center
                label.paddingRight = 32
                label.minimumScaleFactor = 0.5
                label.adjustsFontSizeToFitWidth = true
                label.paddingTop = 6
                label.paddingBottom = 6
                label.roundedCorners([.bottomLeft,.bottomRight,.topLeft,.topRight], radius: 10)
                label.text = data.title
                
                objectLabel.append(label)
            }
            
            objectLabel.forEach { label in
                objectStacView.addArrangedSubview(label)
            }
            
            objectStacView.layoutSubviews()
            
        }
        
        
        switchCameraButton.addTarget(self, action: #selector(switchCamera(_:)), for: .touchUpInside)
        flashCameraButton.addTarget(self, action: #selector(flashCamera(_:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(onBack(_:)), for: .touchUpInside)
        captureImageButton.addTarget(self, action: #selector(captureImage(_:)), for: .touchUpInside)
        confirmPhotoButton.addTarget(self, action: #selector(confirmPhoto(_:)), for: .touchUpInside)
        
//        let captureTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(autoFocusGesture(_:)))
//        captureTapGesture.numberOfTapsRequired = 1
//        captureTapGesture.numberOfTouchesRequired = 1
//        self.previewView.addGestureRecognizer(captureTapGesture)
//
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
//        self.previewView.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    @objc func autoFocusGesture(_ sender: UITapGestureRecognizer){
        
        let touchPoint: CGPoint = sender.location(in: self.view)
        
        if let fsquare = self.focusSquare {
            fsquare.updatePoint(touchPoint)
        }else{
            self.focusSquare = CameraFocusSquare(touchPoint: touchPoint)
            self.view.addSubview(self.focusSquare!)
            self.focusSquare?.setNeedsDisplay()
        }
        
        self.focusSquare?.animateFocusingAction()
        
        let convertedPoint = self.previewLayer.captureDevicePointConverted(fromLayerPoint: touchPoint)
        
        
        //Assign Auto Focus and Auto Exposour
        if let device = backCameraOn ? backCamera : frontCamera {
            do {
                try! device.lockForConfiguration()
                if device.isFocusPointOfInterestSupported{
                    //Add Focus on Point
                    device.focusPointOfInterest = convertedPoint
                    device.focusMode = AVCaptureDevice.FocusMode.autoFocus
                }
                
                if device.isExposurePointOfInterestSupported{
                    //Add Exposure on Point
                    device.exposurePointOfInterest = convertedPoint
                    device.exposureMode = AVCaptureDevice.ExposureMode.autoExpose
                }
                device.unlockForConfiguration()
            }
        }
        
    }
    
    
    func updateView(){
        if takePicture {
            confirmPhotoButton.isHidden = false
            confirmPhotoButton.isEnabled = true
            cancelButton.isHidden = false
            cancelButton.isEnabled = true
            
            cancelButton.setTitle("Retake", for: .normal)
            
            print("HIDDEN TRUE?")
            switchCameraButton.isHidden = true
            flashCameraButton.isHidden = true
            pictureLabel.isHidden = true
            captureImageButton.isHidden = true
            
            switchCameraButton.isEnabled = false
            flashCameraButton.isEnabled = false
            pictureLabel.isEnabled = false
            captureImageButton.isEnabled = false
        } else {
            confirmPhotoButton.isHidden = true
            confirmPhotoButton.isEnabled = false
            
            cancelButton.setTitle("Cancel", for: .normal)
            
            switchCameraButton.isHidden = false
            flashCameraButton.isHidden = false
            cancelButton.isHidden = false
            pictureLabel.isHidden = false
            captureImageButton.isHidden = false
            
            switchCameraButton.isEnabled = true
            flashCameraButton.isEnabled = true
            cancelButton.isEnabled = true
            pictureLabel.isEnabled = true
            captureImageButton.isEnabled = true
        }
    }
    
    func updateCameraButton(){
        if canTakePicture {
            captureImageButton.tintColor = .white
            captureImageButton.isEnabled = true
        } else {
            captureImageButton.tintColor = .gray
            captureImageButton.isEnabled = false
        }
    }
    
}

extension ChallengeCameraScene {
    
    //MARK:- Actions
    @objc func captureImage(_ sender: UIButton?){
        takePicture = true
    }
    
    @objc func onBack(_ sender: UIButton?){
        
        if takePicture {
            self.startCaptureSession()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc func confirmPhoto(_ sender: UIButton?){
        //Save Photo Async Here
        //self.selectedImage
        
        print("TAKEN?")
        self.showSelectionAlertWithCompletion(title: "Great Photo", msg: "Continue to review your work?", confirmMsg: "Proceed", cancelMsg: "Another Shoot") { isConfirmed in
            
            EvaluationDataRepository.shared.insertEvaluations(completed: false, level: Int(self.challengeData?.level ?? 0), desc: "", editedImage: self.selectedImage ?? UIImage.init(), rawImage: self.selectedImage ?? UIImage.init(), challenge: self.challengeData!)
            
//            self.previewImage.image = self.selectedImage ?? UIImage.init()
            if isConfirmed{
                //Done saving, now go back
//                self.navigationController?.popToRootViewController(animated: true)
                
                DispatchQueue.main.async {
//                    self.tabBarController?.selectedIndex = 1
                    NotificationCenter.default.post(name: .didReceiveData, object: nil)
                }

            } else {
                //restart
                self.startCaptureSession()
            }
            
        }
        
    }
    
    @objc func switchCamera(_ sender: UIButton?){
        switchCameraInput()
        
        if backCameraOn {
            flashCameraButton.isEnabled = true
            flashCameraButton.isHidden = false
        } else {
            flashCameraButton.isEnabled = false
            flashCameraButton.isHidden = true
            
        }
        
    }
    
    @objc func flashCamera(_ sender: UIButton?){
        toggleFlash()
    }
    
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        
        // note that 'view' here is the overall video preview
        let velocity = sender.velocity(in: view)
        
        if velocity.y > 0 || velocity.y < 0 {
            
            let devitce = backCameraOn ? backCamera : frontCamera
            
            guard let device = devitce else { return }
            
            let minimumZoomFactor: CGFloat = 1.0
            let maximumZoomFactor: CGFloat = min(device.activeFormat.videoMaxZoomFactor, 10.0) // artificially set a max useable zoom of 10x
            
            // clamp a zoom factor between minimumZoom and maximumZoom
            func clampZoomFactor(_ factor: CGFloat) -> CGFloat {
                return min(max(factor, minimumZoomFactor), maximumZoomFactor)
            }
            
            func update(scale factor: CGFloat) {
                do {
                    
                    try device.lockForConfiguration()
                    defer { device.unlockForConfiguration() }
                    device.videoZoomFactor = factor
                } catch {
                    print("\(error.localizedDescription)")
                }
            }
            
            switch sender.state {
            
            case .began:
                initialZoom = device.videoZoomFactor
                
            case .changed:
                
                // distance in points for the full zoom range (e.g. min to max), could be view.frame.height
                let fullRangeDistancePoints: CGFloat = 300.0
                
                // extract current distance travelled, from gesture start
                let currentYTranslation: CGFloat = sender.translation(in: view).y
                
                // calculate a normalized zoom factor between [-1,1], where up is positive (ie zooming in)
                let normalizedZoomFactor = -1 * max(-1,min(1,currentYTranslation / fullRangeDistancePoints))
                
                // calculate effective zoom scale to use
                let newZoomFactor = clampZoomFactor(initialZoom + normalizedZoomFactor * (maximumZoomFactor - minimumZoomFactor))
                
                // update device's zoom factor'
                update(scale: newZoomFactor)
                
            case .ended, .cancelled:
                break
                
            default:
                break
            }
        }
    }
    
    
}

extension ChallengeCameraScene {
    func checkPermissions() {
        let cameraAuthStatus =  AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch cameraAuthStatus {
        case .authorized:
            return
        case .denied:
            abort()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler:
                                            { (authorized) in
                                                if(!authorized){
                                                    abort()
                                                }
                                            })
        case .restricted:
            abort()
        @unknown default:
            fatalError()
        }
    }
}
