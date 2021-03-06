//
//  RootPageViewController.swift
//  Palliative Mobile
//
//  Created by Harry Nelken on 4/9/16.
//  Copyright © 2016 CWRU-SP16. All rights reserved.
//

import UIKit

class RootPageViewController: UIViewController, UIPageViewControllerDataSource {

    var pageIndex: Int = 0
    var texts: [String?] = [ nil,
        "Use links to move from page to page",
        "Bookmark a page to make it easier to access",
        "Bookmark any page, even our special calculators!",
        "Any text you see can be searched for",
        "Don't forget to check the detail text where available!",
        nil
    ]
    var images: [String?] = [nil, "links-tut", "bookmark-tut.png", "calc-tut.png", "search-tut.png", "detail-tut", nil]
    var pageVC: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the page view controller
        pageVC = self.storyboard?.instantiateViewControllerWithIdentifier(kPageViewControllerID) as! UIPageViewController
        pageVC.dataSource = self
        
        if let contentVC = viewControllerForIndex(0) {
            // Set the first page
            pageVC.setViewControllers([contentVC], direction: .Forward, animated: true, completion: nil)
            
            // Add the page controller to the view
            let width = view.frame.size.width
            let height = view.frame.size.height
            pageVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
            addChildViewController(pageVC)
            view.addSubview(pageVC.view)
            pageVC.didMoveToParentViewController(self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segueToSurvey() {
        // Transition to survey view
        pageVC.willMoveToParentViewController(self)
        pageVC.view.removeFromSuperview()
        pageVC.removeFromParentViewController()
        self.performSegueWithIdentifier(kSurveySegueID, sender: self)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        // At end, no further pages
        if pageIndex == images.count + 1 {
            return nil
        }
        
        // Get the current page index, return next view controller
        if let vc = viewController as? PageContentController {
            let index = vc.pageIndex
            return viewControllerForIndex(index + 1)
        }
        else {  // This is first page, give second
            return viewControllerForIndex(1)
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        // At beginning, no previous pages
        if pageIndex == 0 {
            return nil
        }
        
        // Get the current page index, return previous view controller
        let index = (viewController as! PageContentController).pageIndex
        return viewControllerForIndex(index - 1)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return images.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    private func viewControllerForIndex(index: Int) -> UIViewController? {
        
        var controller: PageContentController
        
        if index < 0 || index >= images.count {
            return nil
        }
        else if index == 0 {
            controller = self.storyboard?.instantiateViewControllerWithIdentifier(kFirstTimePageID) as! PageContentController
        }
        else if index == images.count - 1 {
            controller = self.storyboard?.instantiateViewControllerWithIdentifier(kOptOutPageID) as! PageContentController
        }
        else {
            controller = self.storyboard?.instantiateViewControllerWithIdentifier(kPageContentControllerID) as! PageContentController
        }
        
        // Customize the page
        controller.rootController = self
        controller.imageName = images[index]
        controller.labelText = texts[index]
        controller.pageIndex = index
        return controller
    }
}
