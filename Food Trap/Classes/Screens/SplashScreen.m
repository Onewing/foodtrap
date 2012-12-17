//
//  SplashScreen.m
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "SplashScreen.h"
#import "TitleScreen.h"

@interface SplashScreen ()
@property (nonatomic, strong) UIView *testing;
@end


@implementation SplashScreen

-(IBAction)showTitle {
    NSLog(@"Touch");
    TitleScreen *vc = [[TitleScreen alloc] init];
    [[Game sharedGame] show:vc];
}


-(void)update:(CADisplayLink *)displayLink {
    [super update:displayLink];
    CGFloat pixelsPerSecond = 100;
    CGFloat timeElasped = displayLink.duration * displayLink.frameInterval;
    CGFloat actualDistance = pixelsPerSecond * timeElasped;
    [self.testing setFrame:CGRectMake(self.testing.frame.origin.x + actualDistance, self.testing.frame.origin.y, 20, 20)];

    
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"twice");
    self.testing = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 20, 20)];
    [self.testing setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.testing];
}

@end
