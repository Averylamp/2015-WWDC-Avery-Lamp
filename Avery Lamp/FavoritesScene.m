//
//  SkillsScene.m
//  Avery Lamp
//
//  Created by Avery Lamp on 4/7/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

#import "FavoritesScene.h"
#import <CoreMotion/CoreMotion.h>

@interface FavoritesScene()
@property CGSize screenSize;
@property CMMotionManager*motionManager;
@end

static const uint32_t icon = 0x1 <<0;

@implementation FavoritesScene

-(void)didMoveToView:(SKView *)view{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGSize screenSize = CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height * screenScale);
    self.screenSize = screenSize;
    self.view.showsFPS = NO;
    self.view.showsNodeCount = NO;
    SKLabelNode *label = [[SKLabelNode alloc]initWithFontNamed:@"Avenir-Black"];
    label.text = @"Favorites";
    label.name = @"Welcome Label";
    label.position = CGPointMake(screenSize.width/2,screenSize.height * 5 /6);
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    label.fontSize = 100.0f;
    label.fontColor = [UIColor blackColor];
    label.zPosition = -1;
    [self addChild:label];
    
    
    NSString *particlePath = [[NSBundle mainBundle] pathForResource:@"BackgroundParticle" ofType:@"sks"];
    
    SKEmitterNode *particleEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:particlePath];
    particleEmitter.position = CGPointMake(self.screenSize.width/2, label.position.y);
    particleEmitter.particlePositionRange = CGVectorMake(self.screenSize.width, 100);
    [self addChild:particleEmitter];
    
    
    
    SKPhysicsBody* borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    self.physicsBody = borderBody;
    
    SKNode *ObjC = [self nodeWithName:@"Objective-C" andRadius:100 andColor:[UIColor colorWithRed:0.800f green:0.820f blue:0.671f alpha:1.00f] andTextColor:[UIColor blackColor] fontSize:36];

    SKNode *java = [self nodeWithName:@"Swift" andRadius:100 andColor:[UIColor colorWithRed:0.325f green:0.369f blue:0.231f alpha:1.00f]andTextColor:[UIColor whiteColor]fontSize:44];

    SKNode *videoPro = [self nodeWithName:@"Ansel Adams" andRadius:100 andColor:[UIColor colorWithRed:0.518f green:0.173f blue:0.090f alpha:1.00f]andTextColor:[UIColor whiteColor]fontSize:34];

    SKNode *photography = [self nodeWithName:@"Queen" andRadius:75 andColor:[UIColor colorWithRed:0.235f green:0.043f blue:0.137f alpha:1.00f] andTextColor:[UIColor whiteColor]fontSize:30];

    SKNode *squash = [self nodeWithName:@"Five Guys" andRadius:130 andColor:[UIColor colorWithRed:0.902f green:0.557f blue:0.220f alpha:1.00f]andTextColor:[UIColor blackColor] fontSize:50];

    SKNode *bassoon = [self nodeWithName:@"Caramel" andRadius:70 andColor:[UIColor colorWithRed:0.239f green:0.710f blue:0.835f alpha:1.00f]andTextColor:[UIColor blackColor] fontSize:34];

    SKNode *cad = [self nodeWithName:@"Bassoon" andRadius:70 andColor:[UIColor colorWithRed:0.788f green:0.722f blue:0.631f alpha:1.00f]andTextColor:[UIColor blackColor] fontSize:34];

    SKNode *robotics = [self nodeWithName:@"Apple" andRadius:90 andColor:[UIColor colorWithRed:0.451f green:0.663f blue:0.392f alpha:1.00f]andTextColor:[UIColor blackColor] fontSize:38];
    
    SKNode *yankees = [self nodeWithName:@"Yankees" andRadius:90 andColor:[UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.00f]andTextColor:[UIColor blackColor] fontSize:38];
    
    [self addChild:robotics];
    [self addChild:java];
    [self addChild:cad];
    [self addChild:videoPro];
    [self addChild:yankees];
    [self addChild:photography];
    [self addChild:bassoon];
    [self addChild:squash];
    [self addChild:ObjC];
    
    UIButton *quitButton = [[UIButton alloc]initWithFrame:CGRectMake(screenSize.width / 2 - 60, 20, 40,40 )];
    [quitButton setBackgroundImage:[UIImage imageNamed:@"exitButton"] forState:UIControlStateNormal];
    [quitButton addTarget:self action:@selector(exitVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitButton];
    
}
-(void)exitVC{
    [self.VC dismissViewControllerAnimated:YES completion:^{

    }];
}

-(SKNode *)nodeWithName:(NSString *)name andRadius:(int)radius andColor:(UIColor*)color andTextColor:(UIColor *)textColor fontSize:(int)fontSizze{
    SKNode *node = [[SKNode alloc]init];
    node.name = name;
    node.zPosition = 1;
    node.position = CGPointMake(self.screenSize.width * 2/4, self.screenSize.height* 1 /2);
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    node.physicsBody.categoryBitMask = icon;
    node.physicsBody.contactTestBitMask = icon;
    node.physicsBody.affectedByGravity = YES;
    node.physicsBody.allowsRotation = YES;
    

    SKShapeNode *circle = [[SKShapeNode alloc] init];
    CGRect rect=  CGRectMake(-radius, -radius, 2*radius, 2*radius);
    
    circle.name = @"Green Node";
    circle.path = [UIBezierPath bezierPathWithOvalInRect:rect].CGPath;
    circle.fillColor = [SKColor colorWithCGColor:color.CGColor];
    circle.strokeColor = nil;
    circle.position = CGPointMake(0, 0);
    [node addChild:circle];
    
    SKLabelNode *label = [[SKLabelNode alloc]initWithFontNamed:@"ArialMT"];
    label.text = name;
    label.fontSize = fontSizze;
    label.fontColor = textColor;
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    [node addChild:label];
    return node;

}

-(void)update:(NSTimeInterval)currentTime{
    
    if (_motionManager== nil) {
        _motionManager=[[CMMotionManager alloc]init];
        _motionManager.deviceMotionUpdateInterval=0.05;
        [_motionManager startDeviceMotionUpdates];
    }
    
    CMAcceleration gravity=  _motionManager.deviceMotion.gravity;
    self.physicsWorld.gravity = CGVectorMake(gravity.x*20, gravity.y*20);
    
    
}


@end
