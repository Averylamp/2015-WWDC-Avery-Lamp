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
        awardsLabel.text = "Honors"
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
        
        
        
        technology.append(["0","First Tech Challenge Robotics"," First Tech Challenge Robotics\n13th Place World Champtionship April 2015\n1st Place New Jersey \nApr. 2015"])
        
        technology.append(["0","Dream it Code it Win it","Dream it Code it Win it\nsnappr app\nNYC, NY, Apr. 2015"])
        
        
        technology.append(["0","HackBCA, Second Place","HackBCA, Second Place\nSmith app\nThe Bergen County Academies\nNJ, Mar. 2015"])
        
        
        technology.append(["0","NJ State Robotics, Champion","NJ State Robotics, Champion\nFirst Tech Challenge\nMar. 2015"])
        
        technology.append(["0","Code Day NYC, Best Application","Code Day NYC, Best Application\n ViewZik app\nNYC, NY, Feb. 2015"])
        
        
        
        education.append(["0","The Saint Anselm College Book Award","The Saint Anselm College Book Award\nMillburn High School, 2015"])
        
        education.append(["0","Essay contest, Winner","Essay contest, Winner\nMillburn High School, 2015"])
        
        
        education.append(["0","USA Biology Olympiad, Semifinalist","USA Biology Olympiad, Semifinalist\n2014"])
        
        education.append(["0","USA Computing Olympiad, Silver division","USA Computing Olympiad, Silver\n2014"])
        
        education.append(["0","Princeton Engineering Olympiad, Second Place","Princeton Engineering Olympiad, Second Place\nPrinceton University, 2014"])
        
        
        
        squash.append(["0","US Squash National Ranking, 12","US Squash National Ranking, 12\nBoys under 17 division\nDec. 2014"])
        
        squash.append(["0","US Squash Scholar-Athlete Award","US Squash Scholar-Athlete Award\n2014, 2013"])
        
        squash.append(["0","Virginia Jr. Gold tournament, Winner","Virginia Jr. Gold tournament, Winner\nNov. 2014"])
        
        squash.append(["0","Groton Gold tournament, Finalist","Groton Gold tournament, Finalist\nNov. 2014"])
        
        squash.append(["0","Baird E Haney Jr. Gold Championship, Finalist","Baird E Haney Jr. Gold Championship, Finalist\nSep. 2014"])
        
        
        squash.append(["0","US Squash National Ranking, 23","US Squash National Ranking, 23\nBoys under 15 division\nDec. 2012"])
        
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
