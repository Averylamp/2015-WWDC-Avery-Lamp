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
   
    var allNodes = [SKNode]()
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        
        
    }
    
    let node_Mask = 1<<0
    
    func nodeWithSkill(name:String, color:UIColor, fontSize: CGFloat, fontColor: UIColor) -> SKNode{
        var node = SKShapeNode()
        var rect = CGRectMake(-50,-50,100,100)
        node.name = "CircleNode"
        node.path = UIBezierPath(ovalInRect: rect).CGPath
        node.fillColor = color
        node.strokeColor = UIColor.blackColor()
        node.position = CGPointMake(CGRectGetMidX(self.view!.frame), CGRectGetMidY(self.view!.frame))
        node.physicsBody = SKPhysicsBody(circleOfRadius: 50)
//        node.physicsBody?.categoryBitMask = node_Mask
//        node.physicsBody?.contactTestBitMask = node_Mask
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.allowsRotation = false
        
        var label = SKLabelNode(fontNamed: "ArialMT")
        label.text = name;
        label.fontSize = fontSize
        label.fontColor = fontColor
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        node.addChild(label)
        
        return node
    }
    
}
