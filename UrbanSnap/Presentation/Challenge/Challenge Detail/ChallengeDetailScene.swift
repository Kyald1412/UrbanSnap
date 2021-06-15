//
//  ChallengeCameraScene.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 07/06/21.
//

import UIKit

class ChallengeDetailScene: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var levelTitle: UILabel!
    @IBOutlet weak var levelDesc: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var startButton: UIButton!
    
    var scrollWidth: CGFloat! = 0.0
        var scrollHeight: CGFloat! = 0.0
        var imgs = ["Onboarding-Learn", "Onboarding-Practice", "Onboarding-Evaluate"]
        
        override func viewDidLayoutSubviews() {
            scrollWidth = scrollView.frame.size.width
            scrollHeight = scrollView.frame.size.height
        }
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.layoutIfNeeded()
            
            self.navigationController?.navigationBar.prefersLargeTitles = false
            self.navigationController?.navigationBar.backgroundColor = .white
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.navigationBar.tintColor = .black
            self.scrollView.delegate = self
            scrollView.isPagingEnabled = true
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
            // Do any additional setup after loading the view.
            
            var frame = CGRect (x: 0, y: 0, width: 0, height: 0)
            
            for index in 0..<imgs.count {
                frame.origin.x = scrollWidth * CGFloat (index)
                frame.size = CGSize (width: scrollWidth, height: scrollHeight)
                
                let slide = UIView(frame: frame)
                
                //subview
                let imageView = UIImageView.init(image:UIImage.init(named:imgs[index]))
                imageView.frame = CGRect(x: 0, y:0, width: scrollWidth, height: scrollHeight)
                imageView.contentMode = .scaleAspectFit
                
                slide.addSubview(imageView)
                scrollView.addSubview(slide)
            }
            
            scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(imgs.count), height: scrollHeight)
            self.scrollView.contentSize.height = 1.0
            
            pageControl.numberOfPages = imgs.count
            pageControl.currentPage = 0
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            setIndiactorForCurrentPage()
        }
        
        func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
            setIndiactorForCurrentPage()
        }
    
        func setIndiactorForCurrentPage()  {
               let page = (scrollView?.contentOffset.x)!/scrollWidth
               pageControl?.currentPage = Int(page)
        }

    @IBAction func pressButton(_ sender: Any) {
      
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth*CGFloat((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    @IBAction func beginChallenge(_ sender: Any) {
        let evaluationScene = ChallengeCameraView()
        self.navigationController?.pushViewController(evaluationScene, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
