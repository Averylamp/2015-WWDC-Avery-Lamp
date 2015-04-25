//
//  Photography.swift
//  Avery Lamp
//
//  Created by Avery Lamp on 4/23/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

import UIKit

@objc class Photography: UIViewController {
    
    var segmentedControl = UISegmentedControl()
    
    let costaRica = ["River","Sloth","NightBar","HummingbirdShadow","HummingbirdFlight"]
    let deathValley = ["Zebrinski'sPoint2","WeatherVane","SandPattern","SunClouds","Zebrinski'sPoint","Devil'sGolfCourse","MeTakingPhotos"]
    let asburyPark = ["BeforeSunset","SunsetAsburyPark"]
    let jerseyShore = ["WavesHitRocks","WavesOnSide","WavesOnRocks"]
    let fireworks = ["TwoPlanets","GrandFinale","TwoRedBlue","TwoRedBlue","CloseUp","ChristmasFireworks","GrandFinale"]
    let other = ["Airplane","PalmTreeShadows"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        var titleLabel = UILabel(frame: CGRectMake(0, 20, screenWidth, 60))
        titleLabel.text = "Photography"
        titleLabel.font = UIFont(name: "ArialMT", size: 28)
        titleLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(titleLabel)
        
        
        
        var facebookLink = UIButton(frame: CGRectMake(15, 68, screenWidth-30, 30))
        facebookLink.backgroundColor = UIColor(red: 0.227, green: 0.341, blue: 0.584, alpha: 1.0)
        facebookLink.setTitle("Avery Lamp Photography", forState: UIControlState.Normal)
        facebookLink.layer.cornerRadius = 10
        
        
        facebookLink.titleLabel?.textAlignment = NSTextAlignment.Center
        facebookLink.titleLabel?.textColor = UIColor.blackColor()
        facebookLink.titleLabel?.font = UIFont(name: "ArialMT", size: 22)
        facebookLink.addTarget(self, action: "facebookLinkClicked", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(facebookLink)
        
        let items = ["Costa Rica","Death Valley","Asbury Park","The Jersey Shore","Fireworks","Other"]
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 10
        segmentedControl.tintColor = UIColor.redColor()
        segmentedControl.layer.borderColor = UIColor.blackColor().CGColor
        segmentedControl.addTarget(self, action: "segmentedControlChanged:", forControlEvents: .ValueChanged)
        
        var segmentScroll = UIScrollView(frame: CGRectMake(0, 110, screenWidth, 47))
        segmentScroll.contentSize = CGSizeMake(screenWidth*2 + 80, 40)
        segmentedControl.frame = CGRectMake(0, 0, segmentScroll.contentSize.width, segmentScroll.contentSize.height)
        self.view.addSubview(segmentScroll)
        segmentScroll.addSubview(segmentedControl)
        
        var swipeRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        swipeRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeRecognizer)
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        swipeRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRecognizer)
        
        segmentedControlChanged(UISegmentedControl())
        
        var exitButton = UIButton(frame: CGRectMake(screenWidth-60, 0, 60, 60))
        exitButton.backgroundColor = UIColor.redColor()
        exitButton.addTarget(self, action: "ExitVC", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(exitButton)
        self.numberLabel = UILabel(frame: CGRectMake(0, 180 + screenWidth - 30, screenWidth, 30))
        numberLabel.font = UIFont(name: "ArialMT", size: 16)
        numberLabel.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(numberLabel)
        
        setNumberLabel()
        
    }
    
    var numberLabel = UILabel()
    
    func facebookLinkClicked(){
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/AveryLampPhotography")!)
    }
    
    func segmentedControlChanged(sender:UISegmentedControl){
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        currentImages = [UIImageView]()
        var arr = [String]()
        switch sender.selectedSegmentIndex{
        case 0:
            arr = costaRica
        case 1:
            arr = deathValley
            //asdf
        case 2:
            //asdf
            arr = asburyPark
        case 3:
            arr = jerseyShore
            //asdf
        case 4:
            arr = fireworks
            //asdf
        case 5:
            arr = other
        default:
            arr = costaRica
        }
        
        for string in arr{
            var image = UIImage(named: string)
            var height = image!.size.height * (screenWidth / image!.size.width)
            var imageView = UIImageView(frame: CGRectMake(screenWidth, 180, screenWidth, height))
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imageView.image = image
            imageView.tag = 9999
            
            
            currentImages.append(imageView)
            
        }
        arrIndex = 0
        
        animateLeftToUIImageView(currentImages[arrIndex])
    }
    
    var animatingView = false
    var currentImage = UIImageView()
    
    func removeAllImageViews(){
        for view in self.view.subviews{
            if (view.tag == 9999 && view !== currentImage){
                view.removeFromSuperview()
            }
        }
    }
    
    func animateLeftToUIImageView(view:UIImageView){
        if self.animatingView
        {
            return;
        }else{
            self.animatingView = true
        }
        removeAllImageViews()
        view.removeFromSuperview()
        self.view.addSubview(view)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        view.center = CGPointMake(screenWidth * 1.5, screenHeight/2);
        
        UIView.animateWithDuration(0.5, animations: {
            view.center = CGPointMake(screenWidth/2, screenHeight/2)
            }, completion: {
                (value: Bool) in
                self.animatingView = false
                self.currentImage = view
                self.setNumberLabel()
        })
        
        //move other right
        UIView.animateWithDuration(0.5, animations: {
            self.currentImage.center = CGPointMake(-screenWidth/2, screenHeight/2)
            }, completion: {
                (value: Bool) in
        })
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.numberLabel.frame = CGRectMake(0, view.frame.size.height + view.frame.origin.y, screenWidth, 30)
        })

        
    }
    
    func animateRightToUIImageView(view:UIImageView){
        if self.animatingView
        {
            return;
        }else{
            self.animatingView = true
        }
        removeAllImageViews()
        view.removeFromSuperview()
        self.view.addSubview(view)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        view.center = CGPointMake(-screenWidth/2, screenHeight/2);
        
        UIView.animateWithDuration(0.5, animations: {
            view.center = CGPointMake(screenWidth/2, screenHeight/2)
            }, completion: {
                (value: Bool) in
                self.animatingView = false
                self.currentImage = view
                self.setNumberLabel()
        })
        
        
        UIView.animateWithDuration(0.5, animations: {
            self.currentImage.center = CGPointMake(screenWidth * 3 / 2, screenHeight/2)
            }, completion: {
                (value: Bool) in

        })
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.numberLabel.frame = CGRectMake(0, view.frame.size.height + view.frame.origin.y, screenWidth, 30)
        })
        
        
    }

    func setNumberLabel(){
        self.numberLabel.text = String(format: "%d/%d", self.arrIndex + 1, currentImages.count)
    }
    
    func handleSwipe(gesture:UISwipeGestureRecognizer){
        if(gesture.direction == UISwipeGestureRecognizerDirection.Right){
            println("Right")
            if (self.arrIndex > 0){
                self.arrIndex  = self.arrIndex - 1
                animateRightToUIImageView(currentImages[arrIndex])
            }
        }
        if(gesture.direction == UISwipeGestureRecognizerDirection.Left){
            println("Left")
            if (self.arrIndex < self.currentImages.count-1){
                self.arrIndex  = self.arrIndex + 1
                animateLeftToUIImageView(currentImages[arrIndex])
            }
        }
    }
    
    var arrIndex = 0
    var currentImages = [UIImageView]()
    
    override func  prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func ExitVC(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
