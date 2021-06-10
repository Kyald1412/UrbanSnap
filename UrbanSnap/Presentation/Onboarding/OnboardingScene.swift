//
//  ChallengeCameraScene.swift
//  UrbanSnap
//
//  Created by Dhiky Aldwiansyah on 07/06/21.
//

import UIKit

class OnboardingScene: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnGetStarted:UIButton!
    

    var scrollWidth: CGFloat! = 0.0
    var scrollHeight:CGFloat! = 0.0
    
    var titles = ["Learn" , "Practice", "Evaluate"]
    var desc = ["Broaden your knowledge about urban photography by learning new skills in every level", "Stroll around the city and practice shooting as you complete the challenges", "Sit back after practice and evaluate your work for a better photos in the future"]
    var imgs = ["Onboarding-Learn", "Onboarding-Practice", "Onboarding-Evaluate"]
    
    

    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()

        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        
        var frame = CGRect (x: 0, y: 0, width: 0, height: 0)
        
        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat (index)
            frame.size = CGSize (width: scrollWidth, height: scrollHeight)
            
            let slide = UIView(frame: frame)
            
            //subview
            let imageView = UIImageView.init(image: UIImage.init(named:imgs[index]))
            imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x: scrollWidth/2, y: scrollHeight/2-50)
            
            let txt1 = UILabel.init(frame: CGRect(x: 32, y: imageView.frame.maxY+30, width: scrollWidth-64, height: 30))
            txt1.textAlignment = .center
            txt1.font = UIFont.boldSystemFont(ofSize: 34.0)
            txt1.text = titles[index]
            
            let txt2 = UILabel.init(frame: CGRect(x: 32, y: txt1.frame.maxY+10, width: scrollWidth-84, height: 80))
            txt2.textAlignment = .center
            txt2.numberOfLines = 5
            txt2.font = UIFont.systemFont(ofSize: 18.0)
            txt2.text = desc[index]
            
            slide.addSubview(imageView)
            slide.addSubview(txt1)
            slide.addSubview(txt2)
            scrollView.addSubview(slide)
        }
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)
        self.scrollView.contentSize.height = 1.0
        
        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0
    }
    
    @IBAction func getStartedBtn(_sender:UIButton){
        print("to the next page")
        
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth*CGFloat((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            setIndiactorForCurrentPage()
        }
        
        func setIndiactorForCurrentPage()  {
               let page = (scrollView?.contentOffset.x)!/scrollWidth
               pageControl?.currentPage = Int(page)
           }
    }
    
    
}
