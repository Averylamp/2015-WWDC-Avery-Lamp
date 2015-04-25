//
//  Snappr.swift
//  Avery Lamp
//
//  Created by Avery Lamp on 4/25/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

import UIKit

class Snappr: UIViewController {

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
        

        var shortDesc = UILabel(frame: CGRectMake(0, titleImage.frame.size.height, screenWidth , 200))
        shortDesc.numberOfLines = 0
        var text = "Snappr is an organization app that integrates Photo taking with a schedule"
        shortDesc.font = UIFont(name: "Helvetica", size: 18)
        shortDesc.text  = text
        shortDesc.sizeToFit()
        
        shortDesc.layer.cornerRadius = 10
        shortDesc.layer.borderWidth = 1
        shortDesc.layer.borderColor = UIColor(red: 1.0, green: 0.576, blue: 0.247, alpha: 1.0).CGColor
        self.view.addSubview(shortDesc)
        
        
        // Do any additional setup after loading the view.
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
