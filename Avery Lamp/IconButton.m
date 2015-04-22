//
//  IconButton.m
//  AveryLamp2
//
//  Created by Avery Lamp on 4/8/15.
//  Copyright (c) 2015 Avery Lamp. All rights reserved.
//

#import "IconButton.h"

@implementation IconButton

-(instancetype)initWithViewController:(UIViewController*)vc andIconImage:(UIImage *)image andSplashScree:(UIImage *)splashImage{
    self = [super init];
    if (self) {
        self.viewControllerToLaunch = nil;
        
        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self setBackgroundImage:[IconButton colorizeImage:image withColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
        self.iconImage = image;
        self.splashScreen = splashImage;
    }
    
    return self;
}

-(void)refreshNameLabel{
    if (!self.nameLabel) {
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height,self.frame.size.width ,20 )];
        self.nameLabel.text = self.name;
        self.nameLabel.adjustsFontSizeToFitWidth = YES;
        self.nameLabel.minimumScaleFactor = 8./self.nameLabel.font.pointSize;
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font= [UIFont fontWithName:@"Helvetica" size:12];
        self.nameLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.nameLabel];
    }
    self.nameLabel.frame =CGRectMake(0, self.frame.size.height,self.frame.size.width ,15 );
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (UIImage *)colorizeImage:(UIImage *)image withColor:(UIColor *)color {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image]; //your input image
    
    CIFilter *filter= [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:@"inputImage"];
    [filter setValue:[NSNumber numberWithFloat:-0.4] forKey:@"inputBrightness"];
    
    // Your output image
    UIImage *outputImage = [UIImage imageWithCGImage:[context createCGImage:filter.outputImage fromRect:filter.outputImage.extent]];
    return outputImage;
}@end
