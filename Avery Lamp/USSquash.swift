//
//  Snappr.swift
//  Avery Lamp
//
//  Created by Avery Lamp on 4/25/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

import UIKit

class USSquash: UIViewController, UIScrollViewDelegate {
    
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
        var imageForMask = UIImage(named: "USSquashIcon")
        var maskRef = UIImage(named: "AppIconMask")?.CGImage
        
        var mask = CGImageMaskCreate(CGImageGetWidth(maskRef), CGImageGetHeight(maskRef), CGImageGetBitsPerComponent(maskRef), CGImageGetBitsPerPixel(maskRef), CGImageGetBytesPerRow(maskRef), CGImageGetDataProvider(maskRef), nil, false)
        var masked = CGImageCreateWithMask(imageForMask?.CGImage, mask)
        
        var maskedImage = UIImage(CGImage: masked)
        
        titleImage.image = maskedImage
        self.view.addSubview(titleImage)
        
        var ussquashTitleLabel = UILabel(frame: CGRectMake(110, 20, screenWidth - 160, 60))
        ussquashTitleLabel.text = "U.S. Squash"
        ussquashTitleLabel.font = UIFont(name: "Arial-BoldMT", size: 24)
        ussquashTitleLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(ussquashTitleLabel)
        
        var shortDesc = UILabel(frame: CGRectMake(10, titleImage.frame.size.height, screenWidth - 20, 200))
        shortDesc.numberOfLines = 0
        var text = "I created an iPad app for U.S. Squash as an intern over the summer of 2014."
        shortDesc.font = UIFont(name: "Helvetica", size: 20)
        shortDesc.text  = text
        shortDesc.sizeToFit()
        
        //        shortDesc.layer.cornerRadius = 10
        //        shortDesc.layer.borderWidth = 2
        //        shortDesc.layer.borderColor = UIColor(red: 1.0, green: 0.576, blue: 0.247, alpha: 1.0).CGColor
        self.view.addSubview(shortDesc)
        
        
        
        var comingSoon = UIImageView(frame: CGRectMake(0, 0, 0, 0))
//        comingSoon.contentMode = UIViewContentMode.ScaleAspectFit
//        comingSoon.image = UIImage(named: "ComingSoonToAppStore")
        //self.view.addSubview(comingSoon)
        
        var scrollView = UIScrollView(frame: CGRectMake(0, shortDesc.frame.origin.y + 20 + shortDesc.frame.size.height, screenWidth, screenHeight - (shortDesc.frame.origin.y + shortDesc.frame.size.height) - 10))
        scrollView.contentSize = CGSizeMake(screenWidth * 3, comingSoon.frame.origin.y - (shortDesc.frame.origin.y + shortDesc.frame.size.height) - 10)
        scrollView.delegate = self;
        scrollView.pagingEnabled = true
        self.view.addSubview(scrollView)
        
        self.pageControl = UIPageControl(frame: CGRectMake(0, 0, screenWidth, 20))
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.center = CGPointMake(CGRectGetMidX(scrollView.frame), scrollView.frame.size.height + scrollView.frame.origin.y - 20)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0)
        self.pageControl.pageIndicatorTintColor  = UIColor.lightGrayColor()
        self.view.addSubview(self.pageControl)
        
        
        var page1 = UIView(frame: CGRectMake(0, 0, screenWidth, scrollView.frame.size.height))
        var page2 = UIView(frame: CGRectMake(screenWidth, 0, screenWidth, scrollView.frame.size.height))
        var page3 = UIView(frame: CGRectMake(screenWidth * 2, 0, screenWidth, scrollView.frame.size.height))
        scrollView.addSubview(page1)
        scrollView.addSubview(page2)
        scrollView.addSubview(page3)
        
        var tournamentList = UIImageView(frame: CGRectMake(0, 0, page1.frame.size.width * 1.5/2.5, page1.frame.size.height - 30))
        tournamentList.contentMode = UIViewContentMode.ScaleAspectFit
        tournamentList.image = UIImage(named: "TournamentList")
        tournamentList.layer.cornerRadius = 3
        page1.addSubview(tournamentList)
        
        var homeDesc = UITextView(frame: CGRectMake(page1.frame.size.width * 1.5 / 2.5, 0, screenWidth * 1 / 2.5, page1.frame.size.height))
        homeDesc.font = UIFont(name: "Helvetica", size: 16)
        homeDesc.editable = false
        homeDesc.text = "The U.S. Squash app opens to a list of tournaments sorted through options.  A user would click on the tournaments that interests them to see the draws, matches, or live scoring if available."
        page1.addSubview(homeDesc)
        
        
        var smithCreate =  UIImageView(frame: CGRectMake(20, 0, screenWidth - 40, page2.frame.size.height * 1.5 / 2.5))
        smithCreate.contentMode = UIViewContentMode.ScaleAspectFit
        smithCreate.image = UIImage(named: "USSquashTournament")
        page2.addSubview(smithCreate)
        
        var createDesc = UITextView(frame: CGRectMake(20, page2.frame.size.height * 1.5 / 2.5, screenWidth - 40, page2.frame.size.height / 2.5))
        createDesc.font = UIFont(name: "Helvetica", size: 16)
        createDesc.text = "After a user clicks on a tournament, all the tournament divisions and draws load on the screen.  A user can click on each match to get the current rankings of the two players."
        createDesc.editable = false
        page2.addSubview(createDesc)
        
        
        var smithOptions =  UIImageView(frame: CGRectMake(20, 0, screenWidth - 40, page3.frame.size.height * 1.5 / 2.5))
        smithOptions.contentMode = UIViewContentMode.ScaleAspectFit
        smithOptions.image = UIImage(named: "USSquashTournamentInfo")
        page3.addSubview(smithOptions)
        
        var optionsDesc = UITextView(frame: CGRectMake(20, page3.frame.size.height * 1.5 / 2.5, screenWidth - 40, page3.frame.size.height / 2.5))
        optionsDesc.font = UIFont(name: "Helvetica", size: 16)
        optionsDesc.text = "A user can also view data on the tournaments uploaded by U.S. Squash.  It gives the full functionality of the U.S. Squash website."
        optionsDesc.editable = false
        page3.addSubview(optionsDesc)
        
        
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
