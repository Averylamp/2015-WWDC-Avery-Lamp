//
//  Robotics.swift
//  Avery Lamp
//
//  Created by Avery Lamp on 4/24/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

import UIKit

class Robotics: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        var exitButton = UIButton(frame: CGRectMake(screenWidth-60, 0, 60, 60))
        exitButton.backgroundColor = UIColor.redColor()
        exitButton.addTarget(self, action: "ExitVC", forControlEvents:UIControlEvents.TouchUpInside)
        
        var image = UIImage(named: "Robotics Team")
        var teamImage = UIImageView (frame: CGRectMake(0, 0, screenWidth, image!.size.height * (screenWidth / image!.size.width)))
        teamImage.contentMode = UIViewContentMode.ScaleAspectFit
        teamImage.image = image
        var gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.clearColor().CGColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).CGColor]
        gradient.locations = [0.1,0.35]
        teamImage.layer.insertSublayer(gradient, atIndex: 0)
        teamImage.layer.masksToBounds = true
        
        self.view.addSubview(teamImage)
        self.view.addSubview(exitButton)
        
        var titleLabel = UILabel(frame: CGRectMake(0, 140, screenWidth, 50))
        titleLabel.text = "Robotics"
        titleLabel.font = UIFont(name: "Arial-BoldMT", size: 40)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        view.addSubview(titleLabel)
        
        
        var robotImage = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        robotImage.contentMode = UIViewContentMode.ScaleAspectFit
        robotImage.image = UIImage(named: "Robot")
        
        
        
        var textView = UITextView(frame: CGRectMake(0, 190, screenWidth, screenHeight ))
        
        
        
        
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
