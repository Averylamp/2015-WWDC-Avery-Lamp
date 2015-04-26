//
//  Snappr.swift
//  Avery Lamp
//
//  Created by Avery Lamp on 4/25/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

import UIKit

class Snappr: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        var exitButton = UIButton(frame: CGRectMake(screenWidth-60, 0, 60, 60))
        exitButton.backgroundColor = UIColor.redColor()
        exitButton.addTarget(self, action: "ExitVC", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(exitButton)
        
        var titleImage = UIImageView (frame: CGRectMake(0, 0, screenWidth, 150))
        titleImage.contentMode = UIViewContentMode.ScaleAspectFit
        titleImage.image = UIImage(named: "SnapprTitle")
        self.view.addSubview(titleImage)
        

        var shortDesc = UILabel(frame: CGRectMake(10, titleImage.frame.size.height, screenWidth - 20, 200))
        shortDesc.numberOfLines = 0
        var text = "Snappr is an organization app that integrates photos with a schedule."
        shortDesc.font = UIFont(name: "Helvetica", size: 20)
        shortDesc.text  = text
        shortDesc.sizeToFit()
        
//        shortDesc.layer.cornerRadius = 10
//        shortDesc.layer.borderWidth = 2
//        shortDesc.layer.borderColor = UIColor(red: 1.0, green: 0.576, blue: 0.247, alpha: 1.0).CGColor
        self.view.addSubview(shortDesc)
        

        
        var comingSoon = UIImageView(frame: CGRectMake(0, screenHeight-110, screenWidth, 110))
        comingSoon.contentMode = UIViewContentMode.ScaleAspectFit
        comingSoon.image = UIImage(named: "ComingSoonToAppStore")
        self.view.addSubview(comingSoon)
        
        var scrollView = UIScrollView(frame: CGRectMake(0, shortDesc.frame.origin.y + 20 + shortDesc.frame.size.height, screenWidth, comingSoon.frame.origin.y - (shortDesc.frame.origin.y + shortDesc.frame.size.height) - 10))
        scrollView.contentSize = CGSizeMake(screenWidth * 2, comingSoon.frame.origin.y - (shortDesc.frame.origin.y + shortDesc.frame.size.height) - 10)
        scrollView.delegate = self;
        scrollView.pagingEnabled = true
        self.view.addSubview(scrollView)
        
        self.pageControl = UIPageControl(frame: CGRectMake(0, 0, screenWidth, 20))
        self.pageControl.numberOfPages = 2
        self.pageControl.currentPage = 0
        self.pageControl.center = CGPointMake(CGRectGetMidX(scrollView.frame), scrollView.frame.size.height + scrollView.frame.origin.y - 15)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0)
        self.pageControl.pageIndicatorTintColor  = UIColor.lightGrayColor()
        self.view.addSubview(self.pageControl)
        
        
        var page1 = UIView(frame: CGRectMake(0, 0, screenWidth, scrollView.frame.size.height))
        var page2 = UIView(frame: CGRectMake(screenWidth, 0, screenWidth, scrollView.frame.size.height))
        scrollView.addSubview(page1)
        scrollView.addSubview(page2)
        
        var startImage = UIImageView(frame: CGRectMake(20, 0, screenWidth - 40, page1.frame.size.height * 1.5 / 2.5))
        startImage.contentMode = UIViewContentMode.ScaleAspectFit
        startImage.image = UIImage(named: "Snappr Start Screen")
        page1.addSubview(startImage)
        
        var startDesc = UITextView(frame: CGRectMake(20, page1.frame.size.height * 1.5 / 2.5, screenWidth - 40, page1.frame.size.height / 2.5))
        startDesc.font = UIFont(name: "Helvetica", size: 16)
        startDesc.text = "This is where the app starts.  It allows users to add as many schedules as wanted"
        page1.addSubview(startDesc)
        
        
        var scheduleImage =  UIImageView(frame: CGRectMake(20, 0, screenWidth - 40, page2.frame.size.height * 1.5 / 2.5))
        scheduleImage.contentMode = UIViewContentMode.ScaleAspectFit
        scheduleImage.image = UIImage(named: "Snappr Schedule")
        page2.addSubview(scheduleImage)
        
        var scheduleDesc = UITextView(frame: CGRectMake(20, page2.frame.size.height * 1.5 / 2.5, screenWidth - 40, page2.frame.size.height / 2.5))
        scheduleDesc.font = UIFont(name: "Helvetica", size: 16)
        scheduleDesc.text = "This is what a schedule looks like.  It automatically stores media in the classes created based on time"
        page2.addSubview(scheduleDesc)
        
        
        // Do any additional setup after loading the view.
    }

    var pageControl = UIPageControl()
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var pageWidth = scrollView.frame.size.width;
        var fractionalPage = scrollView.contentOffset.x / pageWidth;
        var page = lroundf(Float(fractionalPage))
        self.pageControl.currentPage = page;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func  prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func ExitVC(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
