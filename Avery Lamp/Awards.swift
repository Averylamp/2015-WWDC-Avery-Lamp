//
//  Awards.swift
//  Avery Lamp
//
//  Created by Avery Lamp on 4/23/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

import UIKit

@objc class Awards: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var tableView = UITableView(frame: CGRectMake(0, 100, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 100))

    var allAwards = [NSMutableArray]()
    
    var selectedIndexPath = NSIndexPath(forRow: 0, inSection: 1)
    
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
        
        var exitButton = UIButton(frame: CGRectMake(screenWidth-60, 0, 60, 60))
        exitButton.backgroundColor = UIColor.redColor()
        exitButton.addTarget(self, action: "ExitVC", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(exitButton)
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        allAwards.append(["0","HackBCA Second Place","In HackBCA 2 we won second place with our app Smith"])
        allAwards.append(["0","Code Day NYC Best Application","In Code Day we won the best Aplication award for our app ViewZik"])
        
        
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAwards.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "AwardCell")
        
        var trophyImage = UIImageView()
        trophyImage.image = UIImage(named:"awardIcon".stringByAppendingString(allAwards[indexPath.row][0] as! String) )
        trophyImage.userInteractionEnabled = false
        cell.addSubview(trophyImage)
        
        var textView = UITextView()
        textView.userInteractionEnabled = false
        textView.editable = false
        textView.font = UIFont(name: "AmericanTypewriter", size: 14)
        
        if (selectedIndexPath.row == indexPath.row){
            trophyImage.frame = CGRectMake(0, 15, 40, 40)
            textView.frame = CGRectMake(40, 0, UIScreen.mainScreen().bounds.width - 40, 70)
            textView.text = allAwards[indexPath.row][2] as! String
            cell .addSubview(textView)
        }else{
            trophyImage.frame = CGRectMake(0, 0, 40, 40)
            textView.frame = CGRectMake(40, 0, UIScreen.mainScreen().bounds.width - 40, 40)
            textView.text = allAwards[indexPath.row][1] as! String
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
            return 70
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
