//
//  ViewController.h
//  Avery Lamp
//
//  Created by Avery Lamp on 4/3/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "iPhoneViewController.h"
#import "LaunchingViewController.h"
@interface ViewController :LaunchingViewController

@property SKScene *scene;
@property SKView * skView;
@property (weak) iPhoneViewController *iPhoneVC;

@end

