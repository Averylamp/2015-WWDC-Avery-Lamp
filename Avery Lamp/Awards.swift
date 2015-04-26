//
//  Awards.swift
//  Avery Lamp
//
//  Created by Avery Lamp on 4/23/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

import UIKit

@objc class Awards: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var tableView = UITableView(frame: CGRectMake(0, 150, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 100))
    
    var segmentedControl = UISegmentedControl()

//    var allAwards = [NSMutableArray]()
    
    var currentAwards = Array<[String]>()
    
    var selectedIndexPath = NSIndexPath(forRow: 0, inSection: 1)
    
    var technology = Array<[String]>()
    var education = Array<[String]>()
    var squash = Array<[String]>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        var awardsLabel = UILabel(frame: CGRectMake(0, 0, screenWidth, 100))
        awardsLabel.text = "Awards"
        awardsLabel.textAlignment = NSTextAlignment.Center
        awardsLabel.font = UIFont(name: "DINAlternate-Bold", size: 50)
        self.view.addSubview(awardsLabel)
        
        var exitButton = UIButton(frame: CGRectMake(screenWidth-60, 20, 40, 40))
//        exitButton.backgroundColor = UIColor.redColor()
        exitButton.setBackgroundImage(UIImage(named: "exitButton"), forState: UIControlState.Normal)
        exitButton.addTarget(self, action: "ExitVC", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(exitButton)
        
        let items = ["Technology", "Education", "Squash"]
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRectMake(10, 105, UIScreen.mainScreen().bounds.width - 20, 40)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 10
        segmentedControl.tintColor = UIColor.redColor()
        segmentedControl.layer.borderColor = UIColor.blackColor().CGColor
        segmentedControl.addTarget(self, action: "segmentedControlChanged:", forControlEvents: .ValueChanged)
        self.view.addSubview(segmentedControl)
        
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        technology.append(["0","HackBCA Second Place","HackBCA Second Place\nWon for my app Smith\nThe Bergen County Academies\nNJ, March, 2015"])
        technology.append(["0","NJ State Robotics Champions","NJ State Robotics Champions\nTeam #8405 Millburn Robotics\nFirst Tech Challenge\nMarch, 2015"])
        technology.append(["0","Code Day NYC Best Application","Code Day NYC Best Application\nWon for my app ViewZik\nNew York City\nNY, February, 2015"])
        
        segmentedControlChanged(UISegmentedControl())
        
        
        
        
    }
    
    func segmentedControlChanged(sender:UISegmentedControl){
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        currentAwards = Array<Array<String>>()
        switch sender.selectedSegmentIndex{
        case 0:
            currentAwards = technology
        case 1:
            currentAwards = education
            //asdf
        case 2:
            //asdf
            currentAwards = squash
        default:
            currentAwards = technology
        }
        
        tableView.reloadData()
        
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAwards.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "AwardCell")
        
        var trophyImage = UIImageView()
        trophyImage.image = UIImage(named:"awardIcon".stringByAppendingString(currentAwards[indexPath.row][0] as String) )
        trophyImage.userInteractionEnabled = false
        cell.addSubview(trophyImage)
        
        var textView = UITextView()
        textView.userInteractionEnabled = false
        textView.editable = false
        textView.font = UIFont(name: "AmericanTypewriter", size: 14)
        
        if (selectedIndexPath.row == indexPath.row){
            trophyImage.frame = CGRectMake(0, 20, 40, 40)
            textView.frame = CGRectMake(40, 0, UIScreen.mainScreen().bounds.width - 40, 80)
            textView.text = currentAwards[indexPath.row][2] as String
            cell .addSubview(textView)
        }else{
            trophyImage.frame = CGRectMake(0, 0, 40, 40)
            textView.frame = CGRectMake(40, 0, UIScreen.mainScreen().bounds.width - 40, 40)
            textView.text = currentAwards[indexPath.row][1] as String
            cell .addSubview(textView)
        }
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 0.235, green: 0.043, blue: 0.137, alpha: 1/0).CGColor
        cell.layer.masksToBounds = true
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(selectedIndexPath.row == indexPath.row){
            return 80
        }else{
            return 40
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
        tableView.reloadData()
        
    }
    
    override func  prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func ExitVC(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
}
