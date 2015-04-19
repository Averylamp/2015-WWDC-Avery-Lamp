//
//  ViewController.h
//  AveryLamp2
//
//  Created by Avery Lamp on 4/8/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRTween.h"

@interface MainViewController : UIViewController{
    //Tween Stuff
    
    PRTweenOperation *activeTweenOperation;
    UIView *animatingView;
    
}

-(void)deallocAllIconVCS;

@end

