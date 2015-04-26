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
#import "FavoritesScene.h"


//Favorites
//Squash
//Projets (most)
//Better Honors
//

@interface MainViewController ()<iPhoneDelegate>

@property CGSize screenSize;

@property NSMutableArray *iPhones;
@property NSMutableArray *iPhoneVCS;
@property iPhoneViewController *currentiPhoneVC;
@property BOOL switchingiPhoneAnimation;

@property int flippingIconIndex;
@property NSMutableArray *flippingIconImages;

@property UIImageView *flippingImageView;

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
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.flippingIconIndex = 0;
    [self addAndAnimateiPhonesToIndex:self.flippingIconIndex];
    
}

-(void)addAndAnimateiPhonesToIndex:(int)index{
    //0 Home 1 Projects 2 Interests
    if (index==0) {
        [self addiPhonesAndAllViews];
        [self animateUpToiPhone:self.currentiPhone];
        [self  animateToRightView:self.rightiPhone];
        [self  animateToLeftView:self.leftiPhone];
        [self.view bringSubviewToFront:self.currentiPhone];
    }else if (index==1){
        [self addiPhonesAndAllViews];
        [self  animateToRightView:self.currentiPhone];
        [self  animateToLeftView:self.rightiPhone];
        [self animateUpToiPhone:self.leftiPhone];
        UIView *temp = self.leftiPhone;
        self.leftiPhone = self.rightiPhone;
        self.rightiPhone = self.currentiPhone;
        self.currentiPhone = temp;
        [self.view bringSubviewToFront:self.currentiPhone];
    }else if (index==2){
        [self addiPhonesAndAllViews];
        [self  animateToRightView:self.leftiPhone];
        [self  animateToLeftView:self.currentiPhone];
        [self animateUpToiPhone:self.rightiPhone];
        UIView *temp = self.rightiPhone;
        self.rightiPhone = self.leftiPhone;
        self.leftiPhone = self.currentiPhone;
        self.currentiPhone = temp;
        [self.view bringSubviewToFront:self.currentiPhone];
    }
    self.flippingImageView.image = [self.flippingIconImages objectAtIndex:index];
    self.flippingIconIndex = index;
}

-(void)initExtras{
    self.iPhones = [[NSMutableArray alloc]init];
    self.iPhoneVCS = [[NSMutableArray alloc]init];
    self.swipeAnimationTime =0.6;
    self.flippingIconImages = [[NSMutableArray alloc]init];
}

-(void)addiPhonesAndAllViews{
    [self initExtras];
    self.view.backgroundColor =[UIColor colorWithRed:0.796f green:0.796f blue:0.796f alpha:1.00f];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.view.gestureRecognizers = [[NSArray alloc]init];
    
    
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
    self.currentiPhone = view;
    iPhoneViewController *blueiPhone = [[iPhoneViewController alloc]initWithImage:[UIImage imageNamed:@"BlueiPhone5c"] withView:view andBackground:[UIImage imageNamed:@"spaceBackground"]];
    blueiPhone.delegate =self;
    blueiPhone.mainVC = self;
    
    
    [blueiPhone addIconWithImage:[UIImage imageNamed:@"QuizUSAIcon"] Name:@"Skills" ViewController:nil andSplashImage:[UIImage imageNamed:@""]];
    [blueiPhone addIconWithImage:[UIImage imageNamed:@"SnapprIcon"] Name:@"Education" ViewController:nil andSplashImage:nil];
    [blueiPhone addIconWithImage:[UIImage imageNamed:@"ViewZikIcon"] Name:@"Awards" ViewController:nil andSplashImage:[UIImage imageNamed:@"ViewZikSplashScreen"]];
    [blueiPhone addIconWithImage:[UIImage imageNamed:@"ViewZikIcon"] Name:@"Contact" ViewController:nil andSplashImage:[UIImage imageNamed:@"ViewZikSplashScreen"]];
    [blueiPhone setupView];
    
    
    [self.iPhones addObject:view];
    [self.iPhoneVCS addObject:blueiPhone];
    
    
    view = [[UIView alloc]initWithFrame:CGRectMake(15, screenSize.height, screenSize.width -30, (screenSize.width - 30) *532.0 /254.0)];
    self.leftiPhone = view;
    //    [self animateToLeftView:view];
    [self.view addSubview:view];
    
    
    iPhoneViewController*pinkiPhone = [[iPhoneViewController alloc]initWithImage:[UIImage imageNamed:@"PinkiPhone5c"] withView:view andBackground:[UIImage imageNamed:@"pinkiPhoneBackground"]];
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
    //    [self animateToRightView:view];
    
    iPhoneViewController*greeniPhone = [[iPhoneViewController alloc]initWithImage:[UIImage imageNamed:@"GreeniPhone5c"] withView:view andBackground:[UIImage imageNamed:@"Lighthouse"]];
    greeniPhone.delegate = self;
    greeniPhone.mainVC = self;
    
    [greeniPhone addIconWithImage:[UIImage imageNamed:@"QuizUSAIcon"] Name:@"Robotics" ViewController:nil andSplashImage:[UIImage imageNamed:@""]];
    [greeniPhone addIconWithImage:[UIImage imageNamed:@"SnapprIcon"] Name:@"Photography" ViewController:nil andSplashImage:nil];
    [greeniPhone addIconWithImage:[UIImage imageNamed:@"ViewZikIcon"] Name:@"Favorites" ViewController:nil andSplashImage:[UIImage imageNamed:@"ViewZikSplashScreen"]];
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
    
    
    //Three flipping icon images
    [self.flippingIconImages addObject:[UIImage imageNamed:@"Headshot"]];
    [self.flippingIconImages addObject:[UIImage imageNamed:@"ProjectsIcon"]];
    [self.flippingIconImages addObject:[UIImage imageNamed:@"ViewZikIcon"]];
    
    
    
    self.flippingImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 125, 125)];
    self.flippingImageView.layer.cornerRadius = 125/2;
    self.flippingImageView.layer.masksToBounds = YES;
    self.flippingImageView.center = CGPointMake(self.screenSize.width/2, self.screenSize.height/3);
    self.flippingImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.flippingImageView];
    
}

#pragma mark - Animation
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
        
        if (self.flippingIconIndex >0) {
            self.flippingIconIndex --;
        }else{
            self.flippingIconIndex = 2;
        }
        [self flipIconImageFromLeft:1 right:0];
        
        UIView *temp;
        temp = self.leftiPhone;
        self.leftiPhone = self.currentiPhone;
        self.currentiPhone = self.rightiPhone;
        self.rightiPhone = temp;
    }else if(gesture.direction ==UISwipeGestureRecognizerDirectionRight){
        
        if (self.flippingIconIndex <2) {
            self.flippingIconIndex ++;
        }else{
            self.flippingIconIndex = 0;
        }
        [self flipIconImageFromLeft:0 right:1];
        
        UIView *temp;
        temp = self.leftiPhone;
        self.leftiPhone = self.rightiPhone;
        self.rightiPhone = self.currentiPhone;
        self.currentiPhone =temp;
    }
    
    [self animateToCenterView:self.currentiPhone];
    [self animateToLeftView:self.leftiPhone];
    [self animateToRightView:self.rightiPhone];
    
    
    
}

-(void)animateToLeftView:(UIView *)view{
    view.userInteractionEnabled = NO;
    CGRect frame = CGRectMake(-65, self.screenSize.height/2-130, 130, 130*532.0 /254.0);
    [self rectLerpTapped:view withFrame:frame duration:self.swipeAnimationTime selector:nil];
    
    
}

-(void)animateToRightView:(UIView *)view{
    view.userInteractionEnabled = NO;
    CGRect frame = CGRectMake(self.screenSize.width-65, self.screenSize.height/2-130, 130, 130*532.0 /254.0);
    [self rectLerpTapped:view withFrame:frame duration:self.swipeAnimationTime selector:nil];
    
    
}
-(void)animateToCenterView:(UIView *)view{
    view.userInteractionEnabled = NO;
    [self.view bringSubviewToFront:view];
    CGRect frame = CGRectMake(15, self.screenSize.height -( (self.screenSize.width - 30) *532.0 /254.0)/2 , self.screenSize.width -30, (self.screenSize.width - 30) *532.0 /254.0);
    [self rectLerpTapped:view withFrame:frame duration:self.swipeAnimationTime selector:@selector(animationComplete)];
    
    
}

-(void)animateUpToiPhone:(UIView *)iPhone {
    iPhone.center = CGPointMake(self.screenSize.width/2, self.screenSize.height * 2.0);
    iPhone.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:self.swipeAnimationTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        iPhone.center = CGPointMake(self.screenSize.width/2, self.screenSize.height);
    } completion:^(BOOL finished) {
        self.currentiPhone = iPhone;
        iPhone.transform = CGAffineTransformIdentity;
        self.switchingiPhoneAnimation = NO;
        [self.view layoutIfNeeded];
    }];
    
}

-(void)animationComplete{
    self.switchingiPhoneAnimation = NO;
    self.currentiPhone.userInteractionEnabled =  YES;
}

-(void)flipIconImageFromLeft:(int)left right:(int)right{
    // Do the first half of the flip
    //    self.flippingImageView.layer.transform = CATransform3DIdentity;
    
    [UIView animateWithDuration:self.swipeAnimationTime/2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.flippingImageView.layer.transform = CATransform3DMakeRotation(M_PI_2,0.0,left-right,0.0); //flip halfway
    } completion:^(BOOL finished) {
        self.flippingImageView.image = [self.flippingIconImages objectAtIndex:self.flippingIconIndex];
        [UIView animateWithDuration:self.swipeAnimationTime/2  delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.flippingImageView.layer.transform = CATransform3DMakeRotation(0,0.0,left-right,0.0);
        } completion:^(BOOL finished) {
            //completion code
        }];
    }];
    
    
    
    
    
}



#pragma mark - PRTween

- (void)update:(PRTweenPeriod*)period {
    if ([period isKindOfClass:[PRTweenCGPointLerpPeriod class]]) {
        animatingView.center = [(PRTweenCGPointLerpPeriod*)period tweenedCGPoint];
    } else {
        //        animatingView.frame = CGRectMake(0, period.tweenedValue, 100, 100);
    }
}

-(void)rectLerpTapped:(UIView*)view withFrame:(CGRect)frame duration:(CGFloat)duration selector:(SEL)selector{
    animatingView = view;
    if (selector) {
        activeTweenOperation = [PRTweenCGRectLerp lerp:animatingView property:@"frame" from:view.frame to:frame duration:duration timingFunction:&PRTweenTimingFunctionSineInOut  target:self completeSelector:selector];
        return;
    }else{
        [PRTweenCGRectLerp lerp:animatingView property:@"frame" from:view.frame to:frame duration:duration];
    }
    
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
    [self rectLerpTapped:iPhoneView withFrame:CGRectMake(-0.08278990644 *iPhoneView.frame.size.width * (self.screenSize.height /iPhoneVC.screenView.frame.size.height ), -0.1503759398 * iPhoneView.frame.size.height * ((self.screenSize.height /iPhoneVC.screenView.frame.size.height )), iPhoneView.frame.size.width * (self.screenSize.height /iPhoneVC.screenView.frame.size.height ), iPhoneView.frame.size.height * ((self.screenSize.height /iPhoneVC.screenView.frame.size.height ))) duration:1 selector:@selector(openIconVC) ];
    
}

-(void)openIconVC{
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
    }
    if ([clickedIcon.name isEqualToString:@"Awards"]) {
        Awards *c = [[Awards alloc]init];
        vc = c;
    }
    if ([clickedIcon.name isEqualToString:@"Photography"]) {
        Photography *c = [[Photography alloc]init];
        vc = c;
    }
    if ([clickedIcon.name isEqualToString:@"Robotics"]) {
        Robotics *c = [[Robotics alloc]init];
        vc = c;
    }
    if ([clickedIcon.name isEqualToString:@"Snappr"]) {
        Snappr *c = [[Snappr alloc]init];
        vc = c;
    }
    if ([clickedIcon.name isEqualToString:@"Skills"]||[clickedIcon.name isEqualToString:@"Favorites"]) {
        ViewController *sceneVC = [[ViewController alloc]init];
        sceneVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        SKView *skView;
        skView = [[SKView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        skView.backgroundColor = [UIColor whiteColor];
        
        if ([clickedIcon.name isEqualToString:@"Skills"]) {
            SkillsScene *scene = [SkillsScene unarchiveFromFile:@"MyScene"];
            scene.VC = sceneVC;
            skView.showsFPS = NO;
            skView.showsNodeCount = NO;
            sceneVC.scene = scene;
            scene.backgroundColor = [UIColor whiteColor];
            sceneVC.view = skView;
            [self  presentViewController:sceneVC animated:YES completion:^{
                self.currentiPhoneVC.iconClicked= NO;
                self.currentiPhoneVC.swipeLocked = NO;
                [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            }];
            return;
        }else if([clickedIcon.name isEqualToString:@"Favorites"]){
            FavoritesScene *scene = [FavoritesScene unarchiveFromFile:@"MyScene"];
            skView.showsFPS = NO;
            skView.showsNodeCount = NO;
            sceneVC.scene = scene;
            scene.backgroundColor = [UIColor whiteColor];
            scene.iPhoneVC = self.currentiPhoneVC;
            scene.VC = sceneVC;
            sceneVC.view = skView;
            [self  presentViewController:sceneVC animated:YES completion:^{
                self.currentiPhoneVC.iconClicked= NO;
                self.currentiPhoneVC.swipeLocked = NO;
                [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            }];
            return;
        }

    }
    
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:vc animated:YES completion:^{
        self.currentiPhoneVC.iconClicked= NO;
        self.currentiPhoneVC.swipeLocked = NO;
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }];
}

#pragma mark - Memory Management

-(void)deallocAllIconVCS{
    for (iPhoneViewController *iPhoneVC in self.iPhoneVCS) {
        [iPhoneVC deallocAllVCsInIcons];
    }
}



@end

