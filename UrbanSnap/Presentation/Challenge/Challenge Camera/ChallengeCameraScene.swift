//
//  ChallengeCameraScene.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 07/06/21.
//

import UIKit
import AVFoundation
import Vision
import CoreMotion
 
struct ChallengeObjectData {
    var title: String
    var isSatisfy: Bool
}

class ChallengeCameraScene: UIViewController {
        
    @IBOutlet weak var switchCameraButton : UIButton!
    @IBOutlet weak var flashCameraButton : UIButton!
    @IBOutlet weak var cancelButton : UIButton!
    @IBOutlet weak var captureImageButton : UIButton!
    @IBOutlet weak var confirmPhotoButton : UIButton!
    @IBOutlet weak var pictureLabel : UILabel!
    @IBOutlet weak var objectStacView : UIStackView!
    var objectLabel = [PaddingLabel]()
    
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
    var canTakePicture = false
    
    // Vision
    var detectionOverlay: CALayer! = nil
    var bufferSize: CGSize = .zero
//    var rootLayer: CALayer! = nil
    var requests = [VNRequest]()
        
    var selectedImage: UIImage? = nil
    
    /*=========================================
    * FOCUS & EXPOSOURE & ZOOM
    ==========================================*/
    var focusSquare: CameraFocusSquare?
    var animateActivity: Bool!
    var initialZoom: CGFloat = 1.0
    
    var orientationLast = UIInterfaceOrientation(rawValue: 0)!
    var motionManager: CMMotionManager?

    var challengeData: Challenges?
    
    var challengeObjectData = [ChallengeObjectData]()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.main.async {
            self.checkPermissions()
            self.startCaptureSession()
        }
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        initializeMotionManager()
        
        setupView()
        updateView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopCaptureSession()
    }
    
    func initializeMotionManager() {
        motionManager = CMMotionManager()
        motionManager?.accelerometerUpdateInterval = 0.2
        motionManager?.gyroUpdateInterval = 0.2
        motionManager?.startAccelerometerUpdates(to: (OperationQueue.current)!, withHandler: {
            (accelerometerData, error) -> Void in
            if error == nil {
                self.outputAccelertionData((accelerometerData?.acceleration)!)
            }
            else {
                print("\(error!)")
            }
        })
    }
    
    func outputAccelertionData(_ acceleration: CMAcceleration) {
       var orientationNew: UIInterfaceOrientation
       if acceleration.x >= 0.75 {
           orientationNew = .landscapeLeft
           print("landscapeLeft")
       }
       else if acceleration.x <= -0.75 {
           orientationNew = .landscapeRight
           print("landscapeRight")
       }
       else if acceleration.y <= -0.75 {
           orientationNew = .portrait
           print("portrait")

       }
       else if acceleration.y >= 0.75 {
           orientationNew = .portraitUpsideDown
           print("portraitUpsideDown")
       }
       else {
           // Consider same as last time
           return
       }

       if orientationNew == orientationLast {
           return
       }
       orientationLast = orientationNew
   }
    
    //MARK:- Camera Setup
    func setupCaptureSession(){
        
        //init session
        self.captureSession = AVCaptureSession()
        //start configuration
        self.captureSession.beginConfiguration()
        
//        if self.captureSession.canSetSessionPreset(.photo) {
//            self.captureSession.sessionPreset = .photo
//        }
        
//                self.captureSession.sessionPreset = .vga640x480 // Model image size is smaller.
        //        self.captureSession.sessionPreset = .vga640x480 // Model image size is smaller.

        //        self.captureSession.sessionPreset = .hd1280x720 // Model image size is smaller.
        self.captureSession.sessionPreset = .medium // Model image size is smaller.

        self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
        
        //setup inputs
        self.setupInputs()
        
        self.setupPreviewLayer()
        
        DispatchQueue.main.async {
//            self.setupLayers()
            self.setupAROutput()
//            self.updateLayerGeometry()
            self.setupVision()
        }
            
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
        self.updateView()
        
        setupCaptureSession()
    }
    
    func stopCaptureSession(){
      
        self.bufferSize = .zero
        self.backCamera = .none
        self.frontCamera = .none
        self.backInput = .none
        self.frontInput = .none
        self.videoOutput = nil
        self.captureSession.stopRunning()

    }
    
    func saveCapturedImage(){
        
        stopCaptureSession()
        
        CommonFunction.shared.flash(layer: self.previewLayer, numberOfFlashes: 1)
        CommonFunction.shared.playSystemSound(id: 1108)
        self.takePicture = true
        self.updateView()
    }
    
}
