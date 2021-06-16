//
//  Step1Controller.swift
//  UrbanSnap
//
//  Created by Wilson Adrilia on 14/06/2021.
//

import UIKit

class Step1Controller: UIViewController {

    @IBOutlet weak var infoButton: UIImageView!
    @IBOutlet weak var step2Button: UIButton!
    @IBOutlet weak var infoDesc: DesignableView!
    
    @IBOutlet weak var imgCanvas: UIImageView!
    private var _selectedStickerView:StickerView?

    @IBAction func onInfoButton(_ sender: Any) {
        infoDesc.isHidden = !infoDesc.isHidden
    }
    
    var selectedStickerView:StickerView? {
        get {
            return _selectedStickerView
        }
        set {
            // if other sticker choosed then resign the handler
            if _selectedStickerView != newValue {
                if let selectedStickerView = _selectedStickerView {
                    selectedStickerView.showEditingHandlers = false
                }
                _selectedStickerView = newValue
            }
            // assign handler to new sticker added
            if let selectedStickerView = _selectedStickerView {
                selectedStickerView.showEditingHandlers = true
                selectedStickerView.superview?.bringSubviewToFront(selectedStickerView)
            }
        }
    }

    var evaluationDetailsData: EvaluationDetails?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Step 1 of 3"
        self.navigationController?.navigationItem.title = "WDSDA"
        
        if let evaluationDetail = evaluationDetailsData {
            self.imgCanvas.image = UIImage(data:evaluationDetail.raw_image ?? Data())
            
            if let objectsData = evaluationDetail.challenge?.challengeObject?.allObjects as? [ChallengeObjects] {
                
                for (index, _) in objectsData.enumerated() {
                    addTestImage(img: "\(index+1).circle.fill", index: index)
                }

            }
        }
       
        // Do any additional setup after loading the view.
    }
    
    func addTestImage(img: String, index: Int){
        let testImage = UIImageView.init(frame: CGRect.init(x: 50, y: 50, width: 35, height: 35))
        testImage.image = UIImage(systemName: img)
        testImage.tintColor = .systemGreen
        testImage.contentMode = .scaleAspectFit
        let sticker1 = StickerView.init(contentView: testImage)
        
        print("boundw \(imgCanvas.frame.maxX)")
        sticker1.center = CGPoint.init(x: imgCanvas.frame.maxX - (35 + 30), y:  imgCanvas.frame.minY + CGFloat(40 * index) + 30)
        sticker1.delegate = self
        sticker1.enableFlip = false
        sticker1.enableClose = false
        sticker1.enableRotate = false
        sticker1.showEditingHandlers = false
        sticker1.tag = 999
        self.imgCanvas.addSubview(sticker1)
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is Step2Controller {
            
            print("SEGUEW pansgis;")
            
            let step2Controller = segue.destination as? Step2Controller
            
            if let image = saveImage(imageView: imgCanvas){
                step2Controller?.editedImage = image
                step2Controller?.evaluationDetailsData = evaluationDetailsData
            }else{
                print("Image not found !!")
            }
        }
    }
   
    
//    @IBAction func btnSaveClick (sender:AnyObject) {
//        selectedStickerView?.showEditingHandlers = false
//        if self.imgCanvas.subviews.filter({$0.tag == 999}).count > 0 {
//            if let image = saveImage(imageView: imgCanvas){
//
////                UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
//            }else{
//                print("Image not found !!")
//            }
//        }else{
////            UIAlertController.showAlertWithOkButton(self, aStrMessage: "No Sticker is available.", completion: nil)
//        }
//    }
    
//    //MARK: - Add image to Library
//    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        if error != nil {
//            // we got back an error!
//            UIAlertController.showAlertWithOkButton(self, aStrMessage: "Save error", completion: nil)
//        } else {
//            UIAlertController.showAlertWithOkButton(self, aStrMessage: "Your image has been saved to your photos.", completion: nil)
//        }
//    }

    func saveImage(imageView: UIImageView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(imageView.frame.size, false, 0.0)
        imageView.superview!.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
}


extension Step1Controller : StickerViewDelegate {
    func stickerViewDidTap(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidClose(_ stickerView: StickerView) {
        
    }
}
