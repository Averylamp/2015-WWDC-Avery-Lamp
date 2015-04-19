//
//  iPhoneViewController.h
//  AveryLamp2
//
//  Created by Avery Lamp on 4/8/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <SpriteKit/SpriteKit.h>
#import "MainViewController.h"
#import "IconButton.h"

@protocol iPhoneDelegate <NSObject>

-(void) iconClicked:(NSObject *)sender;


@end

@interface iPhoneViewController : UIViewController

@property MainViewController *mainVC;

@property UIImageView *iPhoneImage;
@property UIImage * image;
@property NSString *iPhoneType;
@property UIView *screenView;
@property UIImageView *splashScreen;

@property NSMutableArray *icons;
@property BOOL swipeLocked;
@property BOOL animatingResize;
@property BOOL iconClicked;
@property IconButton *clickedIcon;
@property (weak) id <iPhoneDelegate> delegate;

-(instancetype)initWithImage:(UIImage *)image withView:(UIView *)view andBackground:(UIImage *)backgrounImage;
-(void)setupView;


-(void)addIconWithImage:(UIImage *)image Name:(NSString *)name ViewController:(UIViewController *)vc andSplashImage:(UIImage*)splashImage;

-(void)openVC;

-(void)deallocAllVCsInIcons;


@end
