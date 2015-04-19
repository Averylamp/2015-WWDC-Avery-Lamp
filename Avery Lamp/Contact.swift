//
//  Contact.swift
//  Avery Lamp
//
//  Created by Avery Lamp on 4/18/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

import UIKit

@objc class Contact: UIViewController {

        
    func method() {
        println("adsf")
    }
    override func viewDidLoad(){
        self.view.backgroundColor = UIColor.redColor();
        var testLabel:UILabel = UILabel(frame: CGRectMake(0,0,200,200))
        testLabel.center = CGPointMake(200,200)
        testLabel.text = "Test label"
        testLabel.backgroundColor  = UIColor.whiteColor();
        self.view.addSubview(testLabel)
        
    }
}
