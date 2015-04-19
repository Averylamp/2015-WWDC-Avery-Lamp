//
//  IconButton.h
//  AveryLamp2
//
//  Created by Avery Lamp on 4/8/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaunchingViewController.h"
@interface IconButton : UIButton

@property LaunchingViewController *viewControllerToLaunch;
@property UIImage *iconImage;
@property UIImage *splashScreen;
@property NSString *name;
@property UILabel *nameLabel;

-(instancetype)initWithViewController:(LaunchingViewController*)vc andIconImage:(UIImage *)image andSplashScree:(UIImage *)splashImage;
-(void)refreshNameLabel;

@end
