//
//  ViewController.m
//  AveryLamp2
//
//  Created by Avery Lamp on 4/8/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

#import "MainViewController.h"
#import "iPhoneViewController.h"
#import "IconButton.h"
#import "Avery_Lamp-Swift.h"
#import "ViewController.h"
#import "EducationInfoViewController.h"
#import "SkillsScene.h"

@interface MainViewController ()<iPhoneDelegate>

@property CGSize screenSize;

@property NSMutableArray *iPhones;
@property NSMutableArray *iPhoneVCS;
@property iPhoneViewController *currentiPhoneVC;
@property BOOL switchingiPhoneAnimation;
@property int index;

@property double swipeAnimationTime;


@property UIView *currentiPhone;

@property UIView *leftiPhone;
@property UIView *rightiPhone;
@end

#pragma mark - SKScene unarchive
@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation MainViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initExtras];
    
    
    UILabel *welcomeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width,70)];
    welcomeLabel.text = @"Welcome";
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:60];
    [self.view addSubview:welcomeLabel];
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    //    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGSize screenSize = CGSizeMake(screenBounds.size.width , screenBounds.size.height);
    self.screenSize = screenSize;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(15, screenSize.height, screenSize.width -30, (screenSize.width - 30) *532.0 /254.0)];
    [self.view addSubview:view];
    [self.view addSubview:view];
    iPhoneViewController *blueiPhone = [[iPhoneViewController alloc]initWithImage:[UIImage imageNamed:@"BlueiPhone5c"] withView:view andBackground:[UIImage imageNamed:@"Deck"]];
    blueiPhone.delegate =self;
    blueiPhone.mainVC = self;
    
    
    [blueiPhone addIconWithImage:[UIImage imageNamed:@"QuizUSAIcon"] Name:@"Skills" ViewController:nil andSplashImage:[UIImage imageNamed:@""]];
    [blueiPhone addIconWithImage:[UIImage imageNamed:@"SnapprIcon"] Name:@"Education" ViewController:nil andSplashImage:nil];
    [blueiPhone addIconWithImage:[UIImage imageNamed:@"ViewZikIcon"] Name:@"Awards" ViewController:nil andSplashImage:[UIImage imageNamed:@"ViewZikSplashScreen"]];
    [blueiPhone addIconWithImage:[UIImage imageNamed:@"ViewZikIcon"] Name:@"Contact" ViewController:nil andSplashImage:[UIImage imageNamed:@"ViewZikSplashScreen"]];
    [blueiPhone setupView];
    
    
    [self.iPhones addObject:view];
    [self.iPhoneVCS addObject:blueiPhone];
    
    self.currentiPhone = view;
    
    view = [[UIView alloc]initWithFrame:CGRectMake(15, screenSize.height, screenSize.width -30, (screenSize.width - 30) *532.0 /254.0)];
    view.center = CGPointMake(self.screenSize.width/2, self.screenSize.height);
    self.leftiPhone = view;
//    [self animateToLeftView:view];
    [self.view addSubview:view];
    
    
    iPhoneViewController*pinkiPhone = [[iPhoneViewController alloc]initWithImage:[UIImage imageNamed:@"PinkiPhone5c"] withView:view andBackground:[UIImage imageNamed:@"FancyRocks"]];
    pinkiPhone.delegate = self;
    pinkiPhone.mainVC = self;
    
    
    [pinkiPhone addIconWithImage:[UIImage imageNamed:@"SnapprIcon"] Name:@"Snappr" ViewController: nil
                  andSplashImage:[UIImage imageNamed:@"SnapprSplashScreen"]];
    [pinkiPhone addIconWithImage:[UIImage imageNamed:@"ViewZikIcon"] Name:@"ViewZik" ViewController:nil andSplashImage:[UIImage imageNamed:@"ViewZikSplashScreen"]];
    [pinkiPhone addIconWithImage:[UIImage imageNamed:@"SmithIcon"] Name:@"Smith" ViewController:nil andSplashImage:[UIImage imageNamed:@"SmithSplashScreen"]];
    [pinkiPhone addIconWithImage:[UIImage imageNamed:@"QuizUSAIcon"] Name:@"Quiz USA" ViewController:nil andSplashImage:[UIImage imageNamed:@"QuizUSASplashScreen"]];
    
    
    
    [pinkiPhone setupView];
    [self.iPhones addObject:view];
    [self.iPhoneVCS addObject:pinkiPhone];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(15, screenSize.height, screenSize.width -30, (screenSize.width - 30) *532.0 /254.0)];
//    view = [[UIView alloc]initWithFrame:CGRectMake(15, 15, screenSize.width -30, (screenSize.width - 30) *532.0 /254.0)];
    [self.view addSubview:view];
    self.rightiPhone = view;
    view.center = CGPointMake(self.screenSize.width/2, self.screenSize.height);
//    [self animateToRightView:view];
    
    iPhoneViewController*greeniPhone = [[iPhoneViewController alloc]initWithImage:[UIImage imageNamed:@"GreeniPhone5c"] withView:view andBackground:[UIImage imageNamed:@"Lighthouse"]];
    greeniPhone.delegate = self;
    greeniPhone.mainVC = self;
    
    [greeniPhone addIconWithImage:[UIImage imageNamed:@"QuizUSAIcon"] Name:@"Squash" ViewController:nil andSplashImage:[UIImage imageNamed:@""]];
    [greeniPhone addIconWithImage:[UIImage imageNamed:@"SnapprIcon"] Name:@"Photography" ViewController:nil andSplashImage:nil];
    [greeniPhone addIconWithImage:[UIImage imageNamed:@"ViewZikIcon"] Name:@"Music" ViewController:nil andSplashImage:[UIImage imageNamed:@"ViewZikSplashScreen"]];
    [greeniPhone addIconWithImage:[UIImage imageNamed:@"ViewZikIcon"] Name:@"Coding" ViewController:nil andSplashImage:[UIImage imageNamed:@"ViewZikSplashScreen"]];
    
    [greeniPhone setupView];
    [self.iPhones addObject:view];
    [self.iPhoneVCS addObject:greeniPhone];
    
    UISwipeGestureRecognizer *iPhoneSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    iPhoneSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:iPhoneSwipe];
    iPhoneSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    iPhoneSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:iPhoneSwipe];
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self animateUpToiPhone:self.currentiPhone];
    [self  animateToRightView:self.rightiPhone];
    [self  animateToLeftView:self.leftiPhone];
    [self.view bringSubviewToFront:self.currentiPhone];
    
}

-(void)initExtras{
    self.iPhones = [[NSMutableArray alloc]init];
    self.iPhoneVCS = [[NSMutableArray alloc]init];
    self.swipeAnimationTime = 0.6;
}




#pragma mark - Switching between iPhones
-(void)handleSwipeGesture:(UISwipeGestureRecognizer *)gesture{
    iPhoneViewController *currentVC;
    for (iPhoneViewController *vc in self.iPhoneVCS) {
        if([vc.view isEqual:self.currentiPhone]){
            currentVC = vc;
        }
    }
    if(currentVC.swipeLocked){
        return;
    }
    if (self.switchingiPhoneAnimation) {
        return;
    }else{
        self.switchingiPhoneAnimation = YES;
    }
    
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        UIView *temp;
        temp = self.leftiPhone;
        self.leftiPhone = self.currentiPhone;
        self.currentiPhone = self.rightiPhone;
        self.rightiPhone = temp;
    }else if(gesture.direction ==UISwipeGestureRecognizerDirectionRight){
        UIView *temp;
        temp = self.leftiPhone;
        self.leftiPhone = self.rightiPhone;
        self.rightiPhone = self.currentiPhone;
        self.currentiPhone =temp;
    }
    
    [self animateToLeftView:self.leftiPhone];
    [self animateToRightView:self.rightiPhone];
    [self animateToCenterView:self.currentiPhone];

}

-(void)animateToLeftView:(UIView *)view{
    view.userInteractionEnabled = NO;
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform,-self.screenSize.width/2, -250);
    transform = CGAffineTransformScale(transform,0.5, 0.5);
    
    [UIView animateWithDuration:self.swipeAnimationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.transform = transform;
        [self.view layoutIfNeeded];
    } completion:nil];
}

-(void)animateToRightView:(UIView *)view{
    view.userInteractionEnabled = NO;
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform,self.screenSize.width/2, -250);
    transform = CGAffineTransformScale(transform,0.5, 0.5);

    
    [UIView animateWithDuration:self.swipeAnimationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.transform = transform;
                [self.view layoutIfNeeded];
    } completion:nil];

}
-(void)animateToCenterView:(UIView *)view{
    view.userInteractionEnabled = NO;
    [self.view bringSubviewToFront:view];
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform,0,0);
    transform = CGAffineTransformScale(transform,1, 1);
    
    
    [UIView animateWithDuration:self.swipeAnimationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.transform = transform;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.switchingiPhoneAnimation = NO;
        view.userInteractionEnabled = YES;
    }];
}


-(void)switchiPhoneFrom:(UIView*)previousIphone to:(UIView*)targetiPhone{
    if (self.switchingiPhoneAnimation) {
        return;
    }else{
        self.switchingiPhoneAnimation = YES;
    }
    
    [UIView animateWithDuration:self.swipeAnimationTime delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        previousIphone.center = CGPointMake(self.screenSize.width/2, self.screenSize.height * 2.0);
    } completion:^(BOOL finished) {
        if (finished) {
            [self animateUpToiPhone:targetiPhone];
        }
    }];
}

-(void)animateUpToiPhone:(UIView *)iPhone{
    iPhone.center = CGPointMake(self.screenSize.width/2, self.screenSize.height * 2.0);
    
    [UIView animateWithDuration:self.swipeAnimationTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        iPhone.center = CGPointMake(self.screenSize.width/2, self.screenSize.height);
    } completion:^(BOOL finished) {
        self.currentiPhone = iPhone;
        self.switchingiPhoneAnimation = NO;
    }];
}

-(void)animateLeftToiPhone:(UIView *)iPhone{
    iPhone.center = CGPointMake(self.screenSize.width*1.5, self.screenSize.height );
    [UIView animateWithDuration:self.swipeAnimationTime  delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        iPhone.center = CGPointMake(self.screenSize.width/2, self.screenSize.height);
    } completion:^(BOOL finished) {
        self.currentiPhone = iPhone;
        self.switchingiPhoneAnimation = NO;
    }];
}
-(void)animateRightToiPhone:(UIView *)iPhone{
    iPhone.center = CGPointMake(self.screenSize.width*-0.5, self.screenSize.height);
    
    [UIView animateWithDuration:self.swipeAnimationTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        iPhone.center = CGPointMake(self.screenSize.width/2, self.screenSize.height);
    } completion:^(BOOL finished) {
        self.currentiPhone = iPhone;
        self.switchingiPhoneAnimation = NO;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PRTween

- (void)update:(PRTweenPeriod*)period {
    if ([period isKindOfClass:[PRTweenCGPointLerpPeriod class]]) {
        animatingView.center = [(PRTweenCGPointLerpPeriod*)period tweenedCGPoint];
    } else {
        //        animatingView.frame = CGRectMake(0, period.tweenedValue, 100, 100);
    }
}

-(void)rectLerpTapped:(UIView*)view withFrame:(CGRect)frame{
    animatingView = view;
    activeTweenOperation = [PRTweenCGRectLerp lerp:animatingView property:@"frame" from:view.frame to:frame duration:1 timingFunction:&PRTweenTimingFunctionExpoOut  target:self completeSelector:@selector(openIconVC)];
}
#pragma mark - Clicking on Icons

-(void)iconClicked:(NSObject *)sender{
    iPhoneViewController *iPhoneVC = (iPhoneViewController *)sender;
    UIView *iPhoneView;
    
    for (UIView *view in self.iPhones) {
        if ([iPhoneVC.view isEqual:view]) {
            iPhoneView = view;
        }
    }
    
    self.currentiPhoneVC = iPhoneVC;
    [self rectLerpTapped:iPhoneView withFrame:CGRectMake(-0.08278990644 *iPhoneView.frame.size.width * (self.screenSize.height /iPhoneVC.screenView.frame.size.height ), -0.1503759398 * iPhoneView.frame.size.height * ((self.screenSize.height /iPhoneVC.screenView.frame.size.height )), iPhoneView.frame.size.width * (self.screenSize.height /iPhoneVC.screenView.frame.size.height ), iPhoneView.frame.size.height * ((self.screenSize.height /iPhoneVC.screenView.frame.size.height )))];
    
}

-(void)openIconVC{
    
    animatingView =nil;
    
    //    self.currentiPhoneVC.animatingResize =  NO;
    self.currentiPhone.frame = CGRectMake(15, self.screenSize.height, self.screenSize.width -30, (self.screenSize.width - 30) *532.0 /254.0);
    self.currentiPhone.center = CGPointMake(self.screenSize.width/2, self.screenSize.height * 2);
    self.currentiPhoneVC.splashScreen.hidden = YES;
    //[self.currentiPhoneVC setupView];
    [self openIconVCWithIconButton:self.currentiPhoneVC.clickedIcon];
}

-(void)openIconVCWithIconButton:(IconButton*)clickedIcon{
    LaunchingViewController *vc;
    
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if ([clickedIcon.name isEqualToString:@"Education"]) {
        vc = [[EducationInfoViewController alloc]init];
        vc.mainVC = self;
    }
    if ([clickedIcon.name isEqualToString:@"Contact"]) {
        Contact *c = [[Contact alloc]init];
        vc = c;
//        c.mainVC = self;
//        vc.mainVC = self;
    }
    
    if ([clickedIcon.name isEqualToString:@"Skills"]) {
        ViewController *sceneVC = (ViewController*)vc;
        SKView *skView;
        if (![self.view viewWithTag:12534]) {
            skView = [[SKView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            skView.tag = 12534;
            skView.backgroundColor = [UIColor whiteColor];
            //            [self.mainVC.view addSubview:skView];
        }
        if ([clickedIcon.name isEqualToString:@"Skills"]) {
            SkillsScene *scene = [SKScene unarchiveFromFile:@"MyScene"];
            scene.VC = sceneVC;
            scene.backgroundColor = [UIColor whiteColor];
            scene.iPhoneVC = self.currentiPhoneVC;
            sceneVC.scene = scene;
            sceneVC.view = skView;
            
        }
    }
    
    vc.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:vc animated:YES completion:^{
        self.currentiPhoneVC.iconClicked= NO;
        self.currentiPhoneVC.swipeLocked = NO;
    }];
}

#pragma mark - Memory Management

-(void)deallocAllIconVCS{
    for (iPhoneViewController *iPhoneVC in self.iPhoneVCS) {
        [iPhoneVC deallocAllVCsInIcons];
    }
}



@end

