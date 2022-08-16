//
//  TutorialViewController.swift
//  TMDBProject
//
//  Created by 신승아 on 2022/08/16.
//

import UIKit
import TMDBUIFramework

class TutorialViewController: UIPageViewController {
    
    var pageViewControllerList: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPageViewController()
        configurePageViewController()
        
    }
    
    func createPageViewController() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        let vc2 = sb.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        pageViewControllerList = [vc1, vc2]
    }
    
    func configurePageViewController() {
        delegate = self
        dataSource = self
        
        // display
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
    
    
   
}

extension TutorialViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewcontrollerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewcontrollerIndex - 1
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewcontrollerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let nexIndex = viewcontrollerIndex + 1
        return nexIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nexIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        return index
    }
}

