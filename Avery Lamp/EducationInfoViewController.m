//
//  MyInfoViewController.m
//  Avery Lamp
//
//  Created by Avery Lamp on 4/5/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

//<div>Icons made by <a href="http://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a>             is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0">CC BY 3.0</a></div>

#import "EducationInfoViewController.h"
#import "FavoritesScene.h"

@interface EducationInfoViewController ()<UIScrollViewDelegate,MKMapViewDelegate>

@property   UILabel *myInfoLabel;
@property UIView *educationInformation;
@property MKMapView *homeMapView;
@property UIMotionEffectGroup *foregroundEffect;
@property UIMotionEffectGroup *backgroundEffect;
@property CADisplayLink  *displayLink;
@property NSMutableArray *allEducationInformationItems;
@property BOOL educationFadeTriggered;
@property BOOL shouldUpdate;
@property int mapAnimationIndex;

@end

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

@implementation EducationInfoViewController

#pragma mark - ViewDidLoad and extras r

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldUpdate = YES;
    self.view.backgroundColor =[UIColor colorWithRed:0.106f green:0.694f blue:0.541f alpha:1.00f];
    [self addInit];
    self.allEducationInformationItems = [[NSMutableArray alloc]init];
    self.modalPresentationCapturesStatusBarAppearance = YES;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    //    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGSize screenSize = CGSizeMake(screenBounds.size.width , screenBounds.size.height);
    int radius = MIN( screenSize.width / 6 ,screenSize.height /10);
    self.radius = radius;
    int svWidth = self.view.frame.size.width;
    
    
    
    
    //Attributes
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[UIColor blackColor]];
    [shadow setShadowOffset : CGSizeMake (2.0, 2.0)];
    [shadow setShadowBlurRadius : 4];
    
    
    
    UILabel *myInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, svWidth - 60, 80)];
    myInfoLabel.attributedText = [[NSAttributedString alloc]initWithString:@"Education" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Black" size:60],NSShadowAttributeName:shadow}];
    [myInfoLabel addMotionEffect:self.foregroundEffect];
    myInfoLabel.font = [UIFont fontWithName:@"Avenir-Black" size:50];
    myInfoLabel.textAlignment = NSTextAlignmentCenter;
    myInfoLabel.alpha = 0;


    
    [self addEducationInformation];

    self.myInfoLabel = myInfoLabel;
    [self.view addSubview:myInfoLabel];
    // Do any additional setup after loading the view.
    
    UIButton *returnButton = [[UIButton alloc]initWithFrame:CGRectMake(svWidth- 60, 20, 40, 40)];

    [returnButton addTarget:self action:@selector(exitMyInfo) forControlEvents:UIControlEventTouchUpInside];
    [returnButton setImage:[UIImage imageNamed:@"exitButton"] forState:UIControlStateNormal];
    [self.view addSubview:returnButton];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    self.displayLink = displayLink;
    displayLink.frameInterval = 1;
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)addInit{
    //From Stack Overflow
    // Set vertical effect
    int foregroundSensitivity = 40, backgroundSensitivity = 10;
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-foregroundSensitivity);
    verticalMotionEffect.maximumRelativeValue = @(foregroundSensitivity);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-foregroundSensitivity);
    horizontalMotionEffect.maximumRelativeValue = @(foregroundSensitivity);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    self.foregroundEffect = group;
    
    
    UIInterpolatingMotionEffect *verticalMotionEffect2 =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect2.minimumRelativeValue = @(-backgroundSensitivity);
    verticalMotionEffect2.maximumRelativeValue = @(backgroundSensitivity);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect2 =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect2.minimumRelativeValue = @(-backgroundSensitivity);
    horizontalMotionEffect2.maximumRelativeValue = @(backgroundSensitivity);
    
    // Create group to combine both
    UIMotionEffectGroup *group2 = [UIMotionEffectGroup new];
    group2.motionEffects = @[horizontalMotionEffect2, verticalMotionEffect2];
    self.backgroundEffect = group2;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self initialAppearAnimations];
    
}

-(void)initialAppearAnimations{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.myInfoLabel.alpha = 1.0;
    } completion:nil];
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.educationInformation.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self fadeObjects:self.allEducationInformationItems];
    }];
}

-(void)fadeObjects:(NSMutableArray*)array{
    for (UIView *view in array) {
        CGPoint ogCen = CGPointMake(view.center.x, view.center.y-40);
        if (view.tag ==1) {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                view.alpha = 1;
                view.center = ogCen;
            } completion:nil];
        }else if (view.tag ==2){
            [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
                view.alpha = 1;
                view.center = ogCen;
            } completion:nil];
        }else if (view.tag ==3){
            [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
                view.alpha = 1;
                view.center = ogCen;
            } completion:nil];
        }
    }
    
    
    
}

-(void)addEducationInformation{
    //Label Attributes
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[UIColor blackColor]];
    [shadow setShadowOffset : CGSizeMake (2.0, 2.0)];
    [shadow setShadowBlurRadius : 4];
    NSDictionary *labelAttributes =@{NSFontAttributeName: [UIFont fontWithName:@"AlNile-Bold" size:30],NSForegroundColorAttributeName:[UIColor blackColor],NSShadowAttributeName:shadow};
    //@{NSFontAttributeName:[UIFont fontWithName:@"Al Nile-Bold" size:30],NSForegroundColorAttributeName:[UIColor blackColor], NSShadowAttributeName:shadow};
    int svWidth = self.view.frame.size.width;
    
    UIView *educationInformation = [[UIView alloc]initWithFrame:CGRectMake(0, 0, svWidth, self.view.frame.size.height)];
    self.educationInformation = educationInformation;
    educationInformation.alpha = 0;
    //educationInformation.backgroundColor = [UIColor greenColor];
//    [educationInformation addMotionEffect:self.backgroundEffect];
    [self.view addSubview:educationInformation];
    
    UIImageView *backgroundImage= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Sunset"]];
    backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImage.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    [backgroundImage addMotionEffect:self.backgroundEffect];
//    [educationInformation addSubview:backgroundImage];
    NSMutableArray *allLabels = [[NSMutableArray alloc]init];
    
    UIImageView *schoolImage= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"teacher"]];
    schoolImage.tag=1;
    schoolImage.frame = CGRectMake(20, 80, 70, 70);
    [schoolImage addMotionEffect:self.foregroundEffect];
    [educationInformation addSubview:schoolImage];
    [self.allEducationInformationItems addObject:schoolImage];
    
    UILabel *schoolLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 85, svWidth - 90, 35)];
    NSAttributedString *schoolText = [[NSAttributedString alloc]initWithString:@"Millburn High" attributes:labelAttributes];
    schoolLabel.attributedText = schoolText;
    [educationInformation addSubview:schoolLabel];
    UILabel *schoolLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 120, svWidth - 90, 35)];
    NSAttributedString *schoolText2 = [[NSAttributedString alloc]initWithString:@"School" attributes:labelAttributes];
    schoolLabel2.attributedText = schoolText2;
    [educationInformation addSubview:schoolLabel2];
    
    [allLabels addObject:schoolLabel];
    [allLabels addObject:schoolLabel2];
    
    UIImageView *graduateImage= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"graduateHat"]];
    graduateImage.tag = 1;
    graduateImage.frame = CGRectMake(20, 170, 70, 70);
    [graduateImage addMotionEffect:self.foregroundEffect];
    [educationInformation addSubview:graduateImage];
    [self.allEducationInformationItems addObject:graduateImage];
    
    UILabel *graduateLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 175, svWidth - 90, 35)];
    NSAttributedString *graduateText = [[NSAttributedString alloc]initWithString:@"Class of" attributes:labelAttributes];
    graduateLabel.attributedText = graduateText;
    [educationInformation addSubview:graduateLabel];
    UILabel *graduateLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 210, svWidth - 90, 35)];
    NSMutableAttributedString *graduateText2 = [[NSMutableAttributedString alloc]initWithString:@"2016"];
    [graduateText2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldMT" size:30] range:(NSRange){0,4}];
    [graduateText2 addAttribute:NSShadowAttributeName value:shadow range:(NSRange){0,4}];
    graduateLabel2.attributedText = graduateText2;
    [educationInformation addSubview:graduateLabel2];
    
    [allLabels addObject:graduateLabel];
    [allLabels addObject:graduateLabel2];
    
    UIImageView *homeImage= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home"]];
    homeImage.tag = 1;
    homeImage.frame = CGRectMake(20, 260, 70, 70);
    [homeImage addMotionEffect:self.foregroundEffect];
    [educationInformation addSubview:homeImage];
    [self.allEducationInformationItems addObject:homeImage];
    
    UILabel *homeLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 265, svWidth - 90, 35)];
    NSAttributedString *homeText = [[NSAttributedString alloc]initWithString:@"Short Hills," attributes:labelAttributes];
    homeLabel.attributedText = homeText;
    [educationInformation addSubview:homeLabel];
    UILabel *homeLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 300, svWidth - 90, 35)];
    NSAttributedString *homeText2 = [[NSAttributedString alloc]initWithString:@"New Jersey" attributes:labelAttributes];
    homeLabel2.attributedText = homeText2;
    [educationInformation addSubview:homeLabel2];
    
    [allLabels addObject:homeLabel];
    [allLabels addObject:homeLabel2];
    
    for (UILabel *label in allLabels) {
        label.tag = 2;
        label.textAlignment = NSTextAlignmentCenter;
        [label addMotionEffect:self.foregroundEffect];
        [self.allEducationInformationItems addObject:label];
    }
    
    
//    MKMapView *homeMapView= [[MKMapView alloc]initWithFrame:CGRectMake(15, 355, educationInformation.frame.size.width-30, educationInformation.frame.size.height - 355-30)];
    
    //Crashes strangely on my dad's iphone 6
    MKMapView *homeMapView= [[ MKMapView alloc]init];
    homeMapView.frame = CGRectMake(15, 355, educationInformation.frame.size.width-30, educationInformation.frame.size.height - 355-30);
    homeMapView.tag = 3;
    [self.allEducationInformationItems addObject:homeMapView];
    for (UIView *view in self.allEducationInformationItems) {
        CGPoint ogCen = view.center;
        view.center= CGPointMake(ogCen.x, ogCen.y+ 40);
        view.alpha = 0;
    }
    [homeMapView addMotionEffect:self.foregroundEffect];
    self.homeMapView = homeMapView;
    homeMapView.layer.cornerRadius = 20;
    homeMapView.delegate = self;
    
    [educationInformation addSubview:homeMapView];
    
    MKPointAnnotation *myHome = [[MKPointAnnotation alloc]init];
    myHome.coordinate = CLLocationCoordinate2DMake(40.736613, -74.33061700000002);
    myHome.title = @"My Home";
    myHome.subtitle = @"This is where I live";
    [homeMapView addAnnotation:myHome];
    MKPointAnnotation *mySchool = [[MKPointAnnotation alloc]init];
    mySchool.coordinate = CLLocationCoordinate2DMake(40.7203494, -74.3161093);
    mySchool.title = @"My School";
    mySchool.subtitle = @"This is where I go to school";
    [homeMapView addAnnotation:mySchool];
    MKPointAnnotation *thisPicture = [[MKPointAnnotation alloc]init];
    
    thisPicture.coordinate = CLLocationCoordinate2DMake(40.2203907, -74.01208170000001);
    thisPicture.title = @"Asbury Park";
    thisPicture.subtitle = @"This is where I took the background sunset";
    [homeMapView addAnnotation:thisPicture];
    
    homeMapView.centerCoordinate = mySchool.coordinate;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(myHome.coordinate, 1000000, 1000000);
    MKCoordinateRegion adjustedRegion = [homeMapView regionThatFits:viewRegion];
    [homeMapView setRegion:adjustedRegion animated:YES];
    homeMapView.showsUserLocation = YES;
    
    
}
#pragma mark - Fancy Maps
//
-(void)zoomHomeMapView{
    //1,000,000 -> 5,000
    int xval =abs(MAX(self.mapAnimationIndex,1));
//    NSLog(@"xval - %d",xval);
    int zoomDistance = MAX(1001171 - 146129.156*log(xval),5000);
//    NSLog(@"Zoom - %d",zoomDistance);
    if (zoomDistance==5000) {
        self.shouldUpdate = NO;
    }
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance( CLLocationCoordinate2DMake((40.7203494  + 40.736613 )/2, (-74.3161093 -74.33061700000002)/2), zoomDistance,zoomDistance);
    MKCoordinateRegion adjustedRegion = [self.homeMapView regionThatFits:viewRegion];
    [self.homeMapView setRegion:adjustedRegion animated:NO];
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPointAnnotation *pointAnnotation = (MKPointAnnotation *)annotation;
    if([pointAnnotation.title isEqualToString:@"My Home"]||[pointAnnotation.title isEqualToString:@"My School"]){
        MKPinAnnotationView *pinAnnotation = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"PinAnnotation"];
        pinAnnotation.annotation = pointAnnotation;
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        if ([pointAnnotation.title isEqualToString:@"My Home"]) {
            image.image = [UIImage imageNamed:@"home"];
        }else if([pointAnnotation.title isEqualToString:@"My School"]){
            image.image = [UIImage imageNamed:@"graduateHat"];
        }
        pinAnnotation.canShowCallout = YES;
        pinAnnotation.leftCalloutAccessoryView = image;
        return pinAnnotation;
    }else if([pointAnnotation.title isEqualToString:@"Asbury Park"]){
        MKPinAnnotationView *annotationView= [[MKPinAnnotationView alloc]initWithAnnotation:pointAnnotation reuseIdentifier:@"ViewAnnotation"];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        image.image =[EducationInfoViewController imageResize:[UIImage imageNamed:@"Sunset"] andResizeTo:CGSizeMake(30, 30)];
        annotationView.canShowCallout = YES;
        annotationView.leftCalloutAccessoryView = image;
        return annotationView;
    }
    
    
    
    return nil;
}

#pragma mark - Scroll View
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)exitMyInfo{    
    [self.mainVC dismissViewControllerAnimated:YES completion:^{
        [self.mainVC deallocAllIconVCS];
        self.mainVC = nil;
        [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        self.displayLink = nil;
    }];
    
}

#pragma mark - Helper Functions


+(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


-(void)update{
    if (self.shouldUpdate) {
        self.mapAnimationIndex +=2;
        [self zoomHomeMapView];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
