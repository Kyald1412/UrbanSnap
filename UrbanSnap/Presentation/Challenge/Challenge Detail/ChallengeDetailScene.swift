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
    
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    var challengeDetailList : Challenges?
    var imgs : [ChallengePhotos]?
    
    func setLevelDetail(with challenge: Challenges){
        if let objectPhoto = challenge.challengePhoto?.allObjects as? [ChallengePhotos]{
            imgs = objectPhoto
        }
        levelTitle.text = challenge.title
        levelDesc.text = challenge.long_desc
        if let objectData = challenge.challengeObject?.allObjects as? [ChallengeObjects] {
            for (index, data) in objectData.enumerated(){
                let label = UILabel()
                label.textColor = .black
                label.text = "\(index+1). \(data.desc ?? "")"
                label.font = UIFont.systemFont(ofSize: 17)
                label.numberOfLines = 0
                stackView.addArrangedSubview(label)
            }
        }
        
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
        if let data = challengeDetailList{
            setLevelDetail(with: data)
            
        }
        if let imgs = imgs{
            var frame = CGRect (x: 0, y: 0, width: 0, height: 0)
            
            for index in 0..<imgs.count {
                frame.origin.x = scrollWidth * CGFloat (index)
                frame.size = CGSize (width: scrollWidth, height: scrollHeight)
                
                let slide = UIView(frame: frame)
                
                //subview
                let imageView = UIImageView.init(image:UIImage.init(named:imgs[index].image ?? ""))
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
        let evaluationScene = ChallengeCameraView()
        evaluationScene.challengeData = ChallengeDataRepository.shared.getAllChallenges()[0]
        self.navigationController?.pushViewController(evaluationScene, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth*CGFloat((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
    
}
