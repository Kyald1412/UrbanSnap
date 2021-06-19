/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Contains the object recognition view controller for the Breakfast Finder.
*/

import UIKit
import AVFoundation
import Vision

extension ChallengeCameraScene {
    
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }
        guard backCameraOn else { return }

        do {
            try device.lockForConfiguration()

            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
                self.flashCameraButton.setImage(UIImage.init(systemName: "bolt.slash"), for: .normal)
            } else {
                do {
                    self.flashCameraButton.setImage(UIImage.init(systemName: "bolt.fill"), for: .normal)
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }

            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    func setupInputs(){
        //get back camera
        if let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first {
            backCamera = device
        } else {
            //handle this appropriately for production purposes
            fatalError("no back camera")
        }
        
        //get front camera
        if let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices.first {
            frontCamera = device
        } else {
            fatalError("no front camera")
        }
        
        //now we need to create an input objects from our devices
        guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else {
            fatalError("could not create input device from back camera")
        }
        backInput = bInput
        if !captureSession.canAddInput(backInput) {
            fatalError("could not add back camera input to capture session")
        }
        
        guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else {
            fatalError("could not create input device from front camera")
        }
        frontInput = fInput
        if !captureSession.canAddInput(frontInput) {
            fatalError("could not add front camera input to capture session")
        }
        
        //connect back camera input to session
        captureSession.addInput(backInput)
    }
    
    func setupOutput(){
        videoOutput = AVCaptureVideoDataOutput()
        let videoQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        
        //        if captureSession.canAddOutput(videoOutput) {
        //            captureSession.addOutput(videoOutput)
        //        } else {
        //            fatalError("could not add video output")
        //        }
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
            // Add a video data output
            videoOutput.alwaysDiscardsLateVideoFrames = true
            videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        } else {
            print("Could not add video data output to the session")
            captureSession.commitConfiguration()
            return
        }
        
    }
    
    func setupPreviewLayer(){
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        view.layer.insertSublayer(previewLayer, below: switchCameraButton.layer)
        previewLayer.frame = view.layer.bounds
        
//        if let previewView = challengeCameraView?.previewView {
//            previewView.layer.insertSublayer(previewLayer, below: challengeCameraView?.switchCameraButton.layer)
//            previewLayer.frame = previewView.layer.bounds
//        }
    }
  
    
    func switchCameraInput(){
        //don't let user spam the button, fun for the user, not fun for performance
        switchCameraButton.isUserInteractionEnabled = false
        
        //reconfigure the input
        captureSession.beginConfiguration()
        if backCameraOn {
            captureSession.removeInput(backInput)
            captureSession.addInput(frontInput)
            backCameraOn = false
        } else {
            captureSession.removeInput(frontInput)
            captureSession.addInput(backInput)
            backCameraOn = true
        }
        
        
        //deal with the connection again for portrait mode
        videoOutput.connections.first?.videoOrientation = .portrait
        
        //mirror the video stream for front camera
        videoOutput.connections.first?.isVideoMirrored = !backCameraOn
        
        setupAROutput()
        
        //commit config
        captureSession.commitConfiguration()
        
        //acitvate the camera button again
        switchCameraButton.isUserInteractionEnabled = true
    }
    
}

extension ChallengeCameraScene: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let exifOrientation = exifOrientationFromDeviceOrientation()
        
        print("exifOrientation \(exifOrientation.rawValue)")

        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: [:])
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
        
        print("LAST ORIENTATION\(orientationLast.rawValue)")
        print("ASDSDASD connection ORIENTATION\(connection.videoOrientation.rawValue)")

        
        //Take picture section
        
        if !takePicture {
            return //we have nothing to do with the image buffer
        }

//        //try and get a CVImageBuffer out of the sample buffer
//        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
//            return
//        }
        

        //get a CIImage out of the CVImageBuffer
        var ciImage = CIImage(cvImageBuffer: pixelBuffer)

        switch orientationLast {
        case .portrait:
            ciImage = ciImage.oriented(.up)
        case .landscapeRight:
            ciImage = ciImage.oriented(.right)
        case .landscapeLeft:
            ciImage = ciImage.oriented(.left)
        default:
            break
        }
        
        guard let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent) else { return }
//        let fixedImage = UIImage(cgImage: cgImage)

        
        //get UIImage out of CIImage
        let uiImage = UIImage(cgImage: cgImage)
        print("UIIMGAE ORIENTATION \(uiImage.imageOrientation.rawValue)")
//        uiImage = uiImage.fixOrientation()!

        DispatchQueue.main.async {
            self.selectedImage = uiImage
            self.saveCapturedImage()
        }
    }
        
}
 
