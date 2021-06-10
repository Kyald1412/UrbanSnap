//
//  OnboardingViewController.swift
//  UrbanSnap
//
//  Created by Nuuru Alhusna Shufiya Putri on 09/06/21.
//

import UIKit

class OnboardingViewController: UIPageViewController  {
    

//    lazy var orderedViewControllers: [UIViewController] = {
//        return [self.newVC(viewController: "Learn"),
//                self.newVC(viewController: "Practice"),
//                self.newVC(viewController: "Evaluate")]
//    } ()
//    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.isNavigationBarHidden = true
//        self.dataSource = self
//        if let firstViewController = orderedViewControllers.first {
//            setViewControllers([firstViewController],
//                               direction: .forward, animated: true,
//                               completion: nil)
//        }
      
//        self.delegate = self
//        configurePageControl()
//        setViewControllers([getStartlearn()], direction: .forward, animated: true, completion: nil)
        

        // Do any additional setup after loading the view.
    }
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return 3
//    }
//     func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
//    func getStartlearn() -> Onboarding2ViewController {
//        return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "Learn") as! Onboarding2ViewController
//    }
//    func getStartPractice() -> Onboarding3ViewController {
//        return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "Practice") as! Onboarding3ViewController
//    }
//    func getStartEvaluate() -> OnboardingScene{
//        return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "Evaluate") as! OnboardingScene
//    }

  
    
//    func configurePageControl(){
//        pageControl = UIPageControl(frame: CGRect (x: 0, y: UIScreen.main.bounds.maxY-280, width: UIScreen.main.bounds.width, height: 280))
//        pageControl.numberOfPages = 3
//        //pageControl.currentPage = 0
//        pageControl.tintColor = UIColor.black
//        pageControl.pageIndicatorTintColor = UIColor.gray
//        pageControl.currentPageIndicatorTintColor = UIColor.black
//        pageControl.isUserInteractionEnabled = false
//        self.view.addSubview(pageControl)
//        self.view.backgroundColor = .white
//
//    }
    
//    func newVC(viewController:String) -> UIViewController {
//        return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: viewController)
//    }
    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
////        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
////            return nil
////        }
////        let previousIndex = viewControllerIndex - 1
////
////        guard previousIndex >= 0 else {
////           // return orderedViewControllers.last
////            return nil
////        }
////        guard orderedViewControllers.count > previousIndex else {
////            return nil
////        }
////        return orderedViewControllers [previousIndex]
//        print("view controller before \(viewController)")
//        if viewController is OnboardingScene{
//            pageControl.currentPage = 1
//            return getStartPractice()
//        } else if viewController is Onboarding3ViewController {
//            pageControl.currentPage = 0
//        return getStartlearn()
//        }else{
//            pageControl.currentPage = 0
//            return nil
//        }
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
////        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
////            return nil
////        }
////        let nextIndex = viewControllerIndex + 1
////
////        guard orderedViewControllers.count != nextIndex else {
////            //return orderedViewControllers.first
////            return nil
////        }
////        guard orderedViewControllers.count > nextIndex else {
////            return nil
////        }
////        return orderedViewControllers [nextIndex]
//        print("view controller after\(viewController)")
//        if viewController is Onboarding2ViewController{
//            pageControl.currentPage = 1
//            return getStartPractice()
//        } else if viewController is Onboarding3ViewController {
//            pageControl.currentPage = 2
//        return getStartEvaluate()
//        }else{
//            pageControl.currentPage = 0
//            return nil
//        }
//    }
    
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        let pageContentViewController = pageViewController.viewControllers![0]
//        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!
//
//    }


}

