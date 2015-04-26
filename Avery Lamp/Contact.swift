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
    
    override func viewDidLoad(){
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        self.view.backgroundColor = UIColor.clearColor()
        var backgroundLayer = Colors().gl
        backgroundLayer.frame  = self.view.frame
        view.layer.insertSublayer(backgroundLayer, atIndex: 0)
        
        var titleLabel = UILabel(frame: CGRectMake(0, 70, screenWidth, 50))
        titleLabel.text = "Contact"
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont(name: "Avenir-Black", size: 45)
        self.view.addSubview(titleLabel)
        fadeItems.append(titleLabel)
        
        var exitButton = UIButton(frame: CGRectMake(screenWidth-60, 20, 40, 40))
        //        exitButton.backgroundColor = UIColor.redColor()
        exitButton.setBackgroundImage(UIImage(named: "exitButton"), forState: UIControlState.Normal)
        exitButton.addTarget(self, action: "ExitVC", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(exitButton)
        
        var headshot = UIImageView(frame: CGRectMake(10, screenHeight/3.5, screenWidth/3.2, screenWidth/3.2))
        headshot.image = UIImage(named: "Headshot")
        headshot.contentMode = UIViewContentMode.ScaleAspectFit
        self.view.addSubview(headshot)
        fadeItems.append(headshot)
        
        var name = UILabel(frame: CGRectMake(40 + screenWidth/3.5, screenHeight/3.5,  screenWidth * 2.5/3.5 - 40, CGFloat(40.0)))
        name.text = "Avery Lamp"
        name.font = UIFont(name: "DINAlternate-Bold", size: 36)
        self.view.addSubview(name)
        fadeItems.append(name)
        

        var email = UITextView(frame:CGRectMake(40 + screenWidth/3.5, screenHeight/3.5 + 40,  screenWidth * 2.5/3.5 - 40, CGFloat(40.0)))
        email.text = "averylamp@gmail.com"
        email.textContainer.maximumNumberOfLines = 1
        email.textAlignment = NSTextAlignment.Center
        email.scrollEnabled = false
        email.editable = false
        email.backgroundColor = UIColor.clearColor()
        email.dataDetectorTypes = UIDataDetectorTypes.All
        email.font = UIFont(name: "DINAlternate-Bold",size: 18)
        email.textColor = UIColor.blackColor()
        email.textAlignment = NSTextAlignment.Center
        self.view.addSubview(email)
        fadeItems.append(email)

        
        var phone = UITextView(frame:CGRectMake(40 + screenWidth/3.5, screenHeight/3.5 + 70,  screenWidth * 2.5/3.5 - 40, CGFloat(40.0)))
        phone.text  = "(973)-873-8225"
        phone.textContainer.maximumNumberOfLines = 1
        phone.textAlignment = NSTextAlignment.Center
        phone.scrollEnabled = false
        phone.editable = false
        phone.backgroundColor = UIColor.clearColor()
        phone.dataDetectorTypes = UIDataDetectorTypes.All
        phone.font = UIFont(name: "DINAlternate-Bold",size: 18)
        phone.textColor = UIColor.blackColor()
        phone.textAlignment = NSTextAlignment.Center
        self.view.addSubview(phone)
        fadeItems.append(phone)
        
        var address = UITextView(frame:CGRectMake(40 + screenWidth/3.5, screenHeight/3.5 + 100,  screenWidth * 2.5/3.5 - 40, CGFloat(60.0)))
        address.text  = "85 Stewart Rd,\nShort Hills, NJ"
        address.textContainer.maximumNumberOfLines = 2
        address.textAlignment = NSTextAlignment.Center
        address.scrollEnabled = false
        address.editable = false
        address.backgroundColor = UIColor.clearColor()
        address.dataDetectorTypes = UIDataDetectorTypes.All
        address.font = UIFont(name: "DINAlternate-Bold",size: 18)
        address.textColor = UIColor.blackColor()
        address.textAlignment = NSTextAlignment.Center
        self.view.addSubview(address)
        fadeItems.append(address)


        
        for i in 1...3{
            var button = UIButton(frame: CGRectMake(0, 0, screenWidth/4, screenWidth/4))
            var j = Double(i - 2) * 20
            if i==1{
                button.setBackgroundImage(UIImage(named: "facebookIcon"), forState: UIControlState.Normal)
            }else if i==2{
                button.setBackgroundImage(UIImage(named: "githubIcon"), forState: UIControlState.Normal)
            }else if i==3{
                button.setBackgroundImage(UIImage(named: "twitterIcon"), forState: UIControlState.Normal)
            }
            button.center = CGPointMake( CGFloat((Double(screenWidth) * Double(i) / 4.0) + j) , address.frame.origin.y + 150)
//            button.backgroundColor = UIColor.greenColor()
            button.layer.cornerRadius = screenWidth/8
            button.layer.masksToBounds = true
            button.tag = i
            button.addTarget(self, action: "openLink:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
            fadeItems.append(button)

        }
        
        
        
        for fadeView in fadeItems{
            fadeView.alpha = 0
        }
    }
    
    func openLink(button:UIButton){
        if(button.tag==1){
            println("facebook")
            UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/avery.lamp")!)
        } else if(button.tag==2){
            println("Github")
            UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/Averylamp")!)
        }else if(button.tag==3){
            println("Twitter")
            UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/AveryLamp")!)
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
    let colorBottom = UIColor(red: 160.0/255.0, green: 160.0/255.0, blue: 160.0/255.0, alpha: 1.0).CGColor
    
    let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ colorTop,colorMiddle, colorBottom]
        gl.locations = [ 0.0,0.7, 1.0]
    }
}