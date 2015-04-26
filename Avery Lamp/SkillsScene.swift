//
//  SkillsScene.swift
//  Avery Lamp
//
//  Created by Avery Lamp on 4/25/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

import UIKit
import SpriteKit

class SkillsScene: SKScene {
    
    @objc var VC : UIViewController? = nil
    
    var allNodes = [SKShapeNode]()
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        let scale = UIScreen.mainScreen().scale
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width * scale
        let screenHeight = screenSize.height * scale
        
        var exitButton = UIButton(frame: CGRectMake((screenWidth)/2 - 60, 20, 40, 40))
        //        exitButton.backgroundColor = UIColor.redColor()
        exitButton.setBackgroundImage(UIImage(named: "exitButton"), forState: UIControlState.Normal)
        exitButton.addTarget(self, action: "ExitVC", forControlEvents:UIControlEvents.TouchUpInside)
        self.view?.addSubview(exitButton)
        
        
        var skillsLabel = SKLabelNode(text: "Skills")
        skillsLabel.fontName = "DINAlternate-Bold"
        skillsLabel.fontSize = 130
        skillsLabel.fontColor = UIColor.blackColor()
        skillsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        skillsLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        skillsLabel.position = CGPointMake(screenWidth/2, screenHeight - 125)
        self.addChild(skillsLabel)
        
        var emitter = SKEmitterNode(fileNamed: "BackgroundParticle.sks")
        emitter.position = skillsLabel.position
        self.addChild(emitter)
        
        

        
        let bottomLeft = CGPointMake(screenWidth * 1/4 - 20, screenHeight * 1 / 5)
        let bottomCenter = CGPointMake(screenWidth * 2/4, screenHeight * 1 / 5)
        let bottomRight = CGPointMake(screenWidth * 3/4 + 20, screenHeight * 1 / 5)
        let middleLeft = CGPointMake(screenWidth * 1/4 - 20, screenHeight * 2 / 5)
        let middleCenter = CGPointMake(screenWidth * 2/4, screenHeight * 2 / 5)
        let middleRight = CGPointMake(screenWidth * 3/4 + 20, screenHeight * 2 / 5)
        let topLeft = CGPointMake(screenWidth * 1/4 - 20, screenHeight * 3 / 5)
        let topCenter = CGPointMake(screenWidth * 2/4, screenHeight * 3 / 5)
        let topRight = CGPointMake(screenWidth * 3/4 + 20, screenHeight * 3 / 5)
        
        allPositions.append(topLeft)
        allPositions.append(topCenter)
        allPositions.append(topRight)
        allPositions.append(middleLeft)
        allPositions.append(middleCenter)
        allPositions.append(middleRight)
        allPositions.append(bottomLeft)
        allPositions.append(bottomCenter)
        allPositions.append(bottomRight)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(0, 0, screenWidth, screenHeight))
        
        
        
        
        let radius = screenWidth / 8
        var test =  nodeWithSkill("test", color: UIColor.greenColor(), fontSize: 40, fontColor: UIColor.blackColor(),radius: radius)
        test.position = topLeft
        self.addChild(test)
        
        var java =  nodeWithSkill("Java", color: UIColor.redColor(), fontSize: 40, fontColor: UIColor.blackColor(),radius: radius)
        java.position = topCenter
        self.addChild(java)
        
        var objectiveC =  nodeWithSkill("Objective-C", color: UIColor.greenColor(), fontSize: 40, fontColor: UIColor.blueColor(),radius: radius )
        objectiveC.position = topRight
        self.addChild(objectiveC)
        
        var video =  nodeWithSkill("Video", color: UIColor.blackColor(), fontSize: 40, fontColor: UIColor.blackColor(),radius: radius)
        video.position = middleLeft
        self.addChild(video)
        
        var photoshop =  nodeWithSkill("Photoshop", color: UIColor.purpleColor(), fontSize: 40, fontColor: UIColor.blackColor(),radius: radius)
        photoshop.position = middleCenter
        self.addChild(photoshop)
        
        var cad =  nodeWithSkill("CAD", color: UIColor.orangeColor(), fontSize: 40, fontColor: UIColor.blackColor(),radius: radius)
        cad.position = middleRight
        self.addChild(cad)
        
        var cad2 =  nodeWithSkill("CAD2", color: UIColor.darkGrayColor(), fontSize: 40, fontColor: UIColor.blackColor(),radius: radius)
        cad2.position = bottomLeft
        self.addChild(cad2)
        
        var cad3 =  nodeWithSkill("CAD3", color: UIColor.lightGrayColor(), fontSize: 40, fontColor: UIColor.blackColor(),radius: radius)
        cad3.position = bottomCenter
        self.addChild(cad3)
        
        var cad4 =  nodeWithSkill("CAD4", color: UIColor.lightTextColor(), fontSize: 40, fontColor: UIColor.blackColor(),radius: radius)
        cad4.position = bottomRight
        self.addChild(cad4)
        
        
        
    }
    
    let node_Mask : UInt32 = 0b1
    
    func nodeWithSkill(name:String, color:UIColor, fontSize: CGFloat, fontColor: UIColor , radius: CGFloat) -> SKNode{
        let scale = UIScreen.mainScreen().scale
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width * scale
        let screenHeight = screenSize.height * scale
        
        var node = SKShapeNode()
        var rect = CGRectMake(-radius,-radius,radius*2,radius*2)
        node.name = "CircleNode"
        node.path = UIBezierPath(ovalInRect: rect).CGPath
        node.fillColor = color
        node.strokeColor = UIColor.blackColor()
        node.position = CGPointMake(screenWidth/2, screenHeight / 2)
        node.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        node.physicsBody?.categoryBitMask = node_Mask
        node.physicsBody?.contactTestBitMask = node_Mask
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.linearDamping = 1.3
        node.zPosition = 1
        
        var label = SKLabelNode(fontNamed: "ArialMT")
        label.position = CGPointMake(0, 0)
        label.name = "LabelNode"
        label.text = name;
        label.fontSize = fontSize
        label.fontColor = fontColor
        label.userInteractionEnabled = false
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        node.addChild(label)
        
        self.allNodes.append(node)
        return node
    }
    
    var touchesBegan: Bool = false
    override func  touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.touchesBegan = true
        
        for touch in Array(touches) as! [UITouch] {
            var location = touch.locationInNode(self)
            var touchedNode = self.nodeAtPoint(location)
            
            println(touchedNode.name)
        }
    }
    
    var timeInterval :NSTimeInterval = NSTimeInterval()
    var lastTouchTime: NSDate = NSDate()
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        var now = NSDate();
        self.timeInterval = now.timeIntervalSinceDate(self.lastTouchTime)
        self.lastTouchTime  = NSDate();
        
        
        for touch in Array(touches) as! [UITouch] {
            var location = touch.locationInNode(self)
            var touchedNode = self.nodeAtPoint(location)
            if(touchedNode.name == "LabelNode"){
                touchedNode = touchedNode.parent!
            }
            if(touchedNode.name == "CircleNode"){
                var ptTouch = touch.locationInNode(self)
                var   ptPrevious = touch.previousLocationInNode(self)
                var xMove = ptTouch.x - ptPrevious.x;
                var yMove = ptTouch.y - ptPrevious.y;
                var distance = sqrt ((xMove * xMove) + (yMove * yMove));
                
                touchedNode.position = location;
                touchedNode.physicsBody?.velocity = CGVectorMake(round(xMove) * 30, round(yMove) * 30)
            }
        }
        
        
    }
    
    override func  touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.touchesBegan = false
        startUpdating = true

        //        for touch in Array(touches) as! [UITouch] {
        //            var location = touch.locationInNode(self)
        //            var touchedNode = self.nodeAtPoint(location)
        //            if (touchedNode.name == "LabelNode"){
        //                touchedNode = touchedNode.parent!
        //            }
        //            if (touchedNode.name == "CircleNode"){
        //                if (fabs(touchedNode.physicsBody!.velocity.dx) > 10 || fabs(touchedNode.physicsBody!.velocity.dy) > 10){
        //
        //
        //                    println("Moving")
        //
        //
        //
        //                }
        //
        //            }
        //
        //            
        //        }
        
    }
    
    var resettingNodes: Bool = false
    
    func resetAllNodes(){
        if resettingNodes{
            return
        }else{
            resettingNodes = true
        }
        
        
        let scale = UIScreen.mainScreen().scale
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width * scale
        let screenHeight = screenSize.height * scale
        
        let bottomLeft = CGPointMake(screenWidth * 1/4 - 20, screenHeight * 1 / 5)
        let bottomCenter = CGPointMake(screenWidth * 2/4, screenHeight * 1 / 5)
        let bottomRight = CGPointMake(screenWidth * 3/4 + 20, screenHeight * 1 / 5)
        let middleLeft = CGPointMake(screenWidth * 1/4 - 20, screenHeight * 2 / 5)
        let middleCenter = CGPointMake(screenWidth * 2/4, screenHeight * 2 / 5)
        let middleRight = CGPointMake(screenWidth * 3/4 + 20, screenHeight * 2 / 5)
        let topLeft = CGPointMake(screenWidth * 1/4 - 20, screenHeight * 3 / 5)
        let topCenter = CGPointMake(screenWidth * 2/4, screenHeight * 3 / 5)
        let topRight = CGPointMake(screenWidth * 3/4 + 20, screenHeight * 3 / 5)
        
        var allInPosition = true
        for node in self.allNodes {
            if(!checkIfInPosition(node)){
                allInPosition = false
            }
        }
        
        if(allInPosition){
            resettingNodes = false
            return
        }

        self.allNodes.sort({$0.position.y > $1.position.y })
        var bottomNodes = self.allNodes[6...8]
        var middleNodes = self.allNodes[3...5]
        var topNodes = self.allNodes[0...2]


        
        bottomNodes.sort({$0.position.x < $1.position.x})
        middleNodes.sort({$0.position.x < $1.position.x})
        topNodes.sort({$0.position.x < $1.position.x})
        
        let duration = 1.0
        
        var moveTopLeft = SKAction.moveTo(topLeft, duration: duration)
        var moveTopRight = SKAction.moveTo(topRight, duration: duration)
        var moveTopCenter = SKAction.moveTo(topCenter, duration: duration)
        
        var moveMiddleLeft = SKAction.moveTo(middleLeft, duration: duration)
        var moveMiddleRight = SKAction.moveTo(middleRight, duration: duration)
        var moveMiddleCenter = SKAction.moveTo(middleCenter, duration: duration)
        
        var moveBottomLeft = SKAction.moveTo(bottomLeft, duration: duration)
        var moveBottomRight = SKAction.moveTo(bottomRight, duration: duration)
        var moveBottomCenter = SKAction.moveTo(bottomCenter, duration: duration)
        

        
        
        bottomNodes[0].runAction(moveBottomLeft, completion: {
            self.resettingNodes = false
        })
        bottomNodes[1].runAction(moveBottomCenter)
        bottomNodes[2].runAction(moveBottomRight)
        
        middleNodes[0].runAction(moveMiddleLeft)
        middleNodes[1].runAction(moveMiddleCenter)
        middleNodes[2].runAction(moveMiddleRight)
        
        topNodes[0].runAction(moveTopLeft)
        topNodes[1].runAction(moveTopCenter)
        topNodes[2].runAction(moveTopRight)
    }
    
    var allPositions = [CGPoint]()
    
    func checkIfInPosition(node:SKNode)->Bool{
        var inPosition = false;
        let scale = UIScreen.mainScreen().scale
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width * scale
        let screenHeight = screenSize.height * scale
        
        for point in allPositions{
            var xDist = fabs(node.position.x - point.x)
            var yDist = fabs(node.position.y - point.y)
            var distance = sqrt((xDist * xDist) + (yDist * yDist))
            if(distance < 5){
                inPosition = true
            }
        }
        
        return inPosition
    }
    
    func movementEnded()->Bool{
        var movement = false
        for node in self.allNodes{
            if(fabs(node.physicsBody!.velocity.dx) > 10 || fabs(node.physicsBody!.velocity.dy) > 10){
                movement = true
            }
        }
        
        
        return movement
    }
    
    var startUpdating:Bool = false
    override func update(currentTime: NSTimeInterval) {
        if (!movementEnded() && startUpdating){
            resetAllNodes()
        }
    }
    
    
    func ExitVC(){
        VC?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
