//
//  ChallengeCameraScene.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 07/06/21.
//

import UIKit
import AVFoundation
import Vision

class ChallengeCameraScene: UIViewController {
    
    //MARK:- AVFoundation
    var captureSession : AVCaptureSession!
    var backCamera : AVCaptureDevice!
    var frontCamera : AVCaptureDevice!
    var backInput : AVCaptureInput!
    var frontInput : AVCaptureInput!
    var previewLayer : AVCaptureVideoPreviewLayer!
    var videoOutput : AVCaptureVideoDataOutput!
    
    //MARK:- Vars
    var takePicture = false
    var backCameraOn = true
    
    // Vision
    var detectionOverlay: CALayer! = nil
    var bufferSize: CGSize = .zero
//    var rootLayer: CALayer! = nil
    var requests = [VNRequest]()
    
    var challengeCameraView: ChallengeCameraView? = nil
    
    var selectedImage: UIImage? = nil
    
    /*=========================================
    * FOCUS & EXPOSOURE & ZOOM
    ==========================================*/
    var focusSquare: CameraFocusSquare?
    var animateActivity: Bool!
    var initialZoom: CGFloat = 1.0

    
    //MARK:- Camera Setup
    func setupCaptureSession(){
        
        //init session
        self.captureSession = AVCaptureSession()
        //start configuration
        self.captureSession.beginConfiguration()
        
        if self.captureSession.canSetSessionPreset(.photo) {
            self.captureSession.sessionPreset = .photo
        }
        
//                self.captureSession.sessionPreset = .vga640x480 // Model image size is smaller.
        //        self.captureSession.sessionPreset = .vga640x480 // Model image size is smaller.

//        self.captureSession.sessionPreset = .hd1280x720 // Model image size is smaller.

        self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
        
        //setup inputs
        self.setupInputs()
        
        self.setupPreviewLayer()
        self.setupAROutput()
        self.setupLayers()
        self.updateLayerGeometry()
        self.setupVision()
        
        //commit configuration
        self.captureSession.commitConfiguration()
        
        //start running it
        self.captureSession.startRunning()
    }
    
    func startCaptureSession(){
        
        if previewLayer != nil {
            self.previewLayer.removeFromSuperlayer()
            self.previewLayer = nil
        }
        
        self.selectedImage = nil
        self.takePicture = false
        self.backCameraOn = true
        self.challengeCameraView?.updateView()
        
        setupCaptureSession()
    }
    
    func stopCaptureSession(){
        
//        print(self.view.sub)
        
        CommonFunction.shared.flash(layer: self.previewLayer, numberOfFlashes: 1)
        CommonFunction.shared.playSystemSound(id: 1108)
        self.takePicture = true
        self.captureSession.stopRunning()
        
        self.detectionOverlay.removeFromSuperlayer()
        self.detectionOverlay = nil
        self.bufferSize = .zero
        self.backCamera = .none
        self.frontCamera = .none
        self.backInput = .none
        self.frontInput = .none
        self.videoOutput = nil
        
        self.challengeCameraView?.updateView()

    }
    
}
