//
//  Snappr.swift
//  Avery Lamp
//
//  Created by Avery Lamp on 4/25/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

import UIKit

class ViewZik: UIViewController, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        var exitButton = UIButton(frame: CGRectMake(screenWidth-60, 20, 40, 40))
        //        exitButton.backgroundColor = UIColor.redColor()
        exitButton.setBackgroundImage(UIImage(named: "exitButton"), forState: UIControlState.Normal)
        exitButton.addTarget(self, action: "ExitVC", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(exitButton)
        
        
        var titleImage = UIImageView (frame: CGRectMake(0, 0, 120, 120))
        titleImage.contentMode = UIViewContentMode.ScaleAspectFit
        var imageForMask = UIImage(named: "ViewZikIcon")
        var maskRef = UIImage(named: "AppIconMask")?.CGImage
        
        var mask = CGImageMaskCreate(CGImageGetWidth(maskRef), CGImageGetHeight(maskRef), CGImageGetBitsPerComponent(maskRef), CGImageGetBitsPerPixel(maskRef), CGImageGetBytesPerRow(maskRef), CGImageGetDataProvider(maskRef), nil, false)
        var masked = CGImageCreateWithMask(imageForMask?.CGImage, mask)
        
        var maskedImage = UIImage(CGImage: masked)
        
        titleImage.image = maskedImage
        self.view.addSubview(titleImage)
        
        var viewZikTitleLabel = UILabel(frame: CGRectMake(120, 20, screenWidth - 180, 60))
        viewZikTitleLabel.text = "ViewZik"
        viewZikTitleLabel.font = UIFont(name: "Arial-BoldMT", size: 32)
        viewZikTitleLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(viewZikTitleLabel)
        
        var shortDesc = UILabel(frame: CGRectMake(10, titleImage.frame.size.height, screenWidth - 20, 200))
        shortDesc.numberOfLines = 0
        var text = "ViewZik is a music player that uses the Superpowered SDK for live mixing, effects, and visualization."
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
        scrollView.contentSize = CGSizeMake(screenWidth * 3, comingSoon.frame.origin.y - (shortDesc.frame.origin.y + shortDesc.frame.size.height) - 10)
        scrollView.delegate = self;
        scrollView.pagingEnabled = true
        self.view.addSubview(scrollView)
        
        self.pageControl = UIPageControl(frame: CGRectMake(0, 0, screenWidth, 20))
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.center = CGPointMake(CGRectGetMidX(scrollView.frame), scrollView.frame.size.height + scrollView.frame.origin.y - 15)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0)
        self.pageControl.pageIndicatorTintColor  = UIColor.lightGrayColor()
        self.view.addSubview(self.pageControl)
        
        
        var page1 = UIView(frame: CGRectMake(0, 0, screenWidth, scrollView.frame.size.height))
        var page2 = UIView(frame: CGRectMake(screenWidth, 0, screenWidth, scrollView.frame.size.height))
        var page3 = UIView(frame: CGRectMake(screenWidth * 2, 0, screenWidth, scrollView.frame.size.height))
        scrollView.addSubview(page1)
        scrollView.addSubview(page2)
        scrollView.addSubview(page3)
        
        var viewZikStart = UIImageView(frame: CGRectMake(20, 0, screenWidth - 40, page1.frame.size.height * 1.5 / 2.5))
        viewZikStart.contentMode = UIViewContentMode.ScaleAspectFit
        viewZikStart.image = UIImage(named: "ViewZik1")
        page1.addSubview(viewZikStart)
        
        var startDesc = UITextView(frame: CGRectMake(20, page1.frame.size.height * 1.5 / 2.5, screenWidth - 40, page1.frame.size.height / 2.5))
        startDesc.font = UIFont(name: "Helvetica", size: 16)
        startDesc.text = "This is what the visualizer looks like.  It creates a mirrored waveform based off frequencies."
        startDesc.editable = false
        page1.addSubview(startDesc)
        
        
        var viewZikEffects =  UIImageView(frame: CGRectMake(20, 0, screenWidth - 40, page2.frame.size.height * 1.5 / 2.5))
        viewZikEffects.contentMode = UIViewContentMode.ScaleAspectFit
        viewZikEffects.image = UIImage(named: "ViewZik2")
        page2.addSubview(viewZikEffects)
        
        var scheduleDesc = UITextView(frame: CGRectMake(20, page2.frame.size.height * 1.5 / 2.5, screenWidth - 40, page2.frame.size.height / 2.5))
        scheduleDesc.font = UIFont(name: "Helvetica", size: 16)
        scheduleDesc.text = "The arrows trigger effects.  A user can trigger one or more effects at a time."
        scheduleDesc.editable = false
        page2.addSubview(scheduleDesc)
        
        
        var viewZikLocal =  UIImageView(frame: CGRectMake(20, 0, screenWidth - 40, page3.frame.size.height * 1.5 / 2.5))
        viewZikLocal.contentMode = UIViewContentMode.ScaleAspectFit
        viewZikLocal.image = UIImage(named: "ViewZik3")
        page3.addSubview(viewZikLocal)
        
        var localDesc = UITextView(frame: CGRectMake(20, page3.frame.size.height * 1.5 / 2.5, screenWidth - 40, page3.frame.size.height / 2.5))
        localDesc.font = UIFont(name: "Helvetica", size: 16)
        localDesc.text = "Over the summer I will be implementing a queue player with local files for the user's ease.  "
        localDesc.editable = false
        page3.addSubview(localDesc)
        
        
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
