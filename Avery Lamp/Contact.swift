//
//  Contact.swift
//  Avery Lamp
//
//  Created by Avery Lamp on 4/18/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

import UIKit

@objc class Contact: UIViewController {

    var fadeItems = [UIView]()
    
    func method() {
        println("adsf")
    }
    override func viewDidLoad(){
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        self.view.backgroundColor = UIColor.clearColor()
        var backgroundLayer = Colors().gl
        backgroundLayer.frame  = self.view.frame
        view.layer.insertSublayer(backgroundLayer, atIndex: 0)
        
        var titleLabel = UILabel(frame: CGRectMake(0, 70, screenWidth, 50))
        titleLabel.text = "My Contact Information"
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont(name: "ArialMT", size: 30)
        self.view.addSubview(titleLabel)
        fadeItems.append(titleLabel)
        
        var exitButton = UIButton(frame: CGRectMake(screenWidth-60, 0, 60, 60))
        exitButton.backgroundColor = UIColor.redColor()
        exitButton.addTarget(self, action: "ExitVC", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(exitButton)
        
        var headshot = UIImageView(frame: CGRectMake(20, screenHeight/4, screenHeight/5, screenHeight/5))
        headshot.image = UIImage(named: "Headshot")
        headshot.contentMode = UIViewContentMode.ScaleAspectFit
        self.view.addSubview(headshot)
        fadeItems.append(headshot)
        
        var name = UILabel(frame: CGRectMake(20 + screenHeight/5, screenHeight/4,  CGFloat(-20.0 + Double(screenHeight)*4.0/5.0), CGFloat(40.0)))
        name.text = "Avery Lamp"
        name.font = UIFont(name: "DINAlternate-Bold", size: 36)
        self.view.addSubview(name)
        fadeItems.append(name)
        
        
        
        
        for fadeView in fadeItems{
            fadeView.alpha = 0
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let count = fadeItems.count
        for index in 0...count-1{
            var fadeView = fadeItems[index]
            fadeView.alpha = 0
            UIView.animateWithDuration(0.5, delay: 0.3 * Double(index), options: UIViewAnimationOptions.CurveEaseInOut, animations: { fadeView.alpha = 1.0
            }, completion: nil)
            
        }

    }
    func ExitVC(){
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    override func  prefersStatusBarHidden() -> Bool {
        return true
    }
}

class Colors {
    let colorMiddle = UIColor(red: 189.0/255.0, green: 240.0/255.0, blue: 247.0/255.0, alpha: 1.0).CGColor
    let colorTop = UIColor(red: 142.0/255.0, green: 192.0/255.0, blue: 215.0/255.0, alpha: 1.0).CGColor
    let colorBottom = UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0).CGColor
    
    let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ colorTop,colorMiddle, colorBottom]
        gl.locations = [ 0.0,0.7, 1.0]
    }
}