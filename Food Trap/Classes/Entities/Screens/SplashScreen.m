//
//  SplashScreen.m
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "SplashScreen.h"

@interface SplashScreen ()
@property (nonatomic, strong) UIView *testing;
@end


@implementation SplashScreen

-(void)showTitle {
    NSLog(@"Touch");
}

-(void)setup {
    [super setup];
    
    self.testing = [[UIView alloc] initWithFrame:[self relativeRect:0 y:40 w:20 h:20]];
    [self.testing setBackgroundColor:[UIColor redColor]];
    [self addSubview:self.testing];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:[self relativeRect:100 y:300 w:130 h:44]];
    [btn setTitle:@"Test" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showTitle) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];

}

-(void)update:(CADisplayLink *)displayLink {
    [super update:displayLink];
    CGFloat pixelsPerSecond = 100;
    CGFloat timeElasped = displayLink.duration * displayLink.frameInterval;
    CGFloat actualDistance = pixelsPerSecond * timeElasped;
    [self.testing setFrame:CGRectMake(self.testing.frame.origin.x + actualDistance, self.testing.frame.origin.y, 20, 20)];

    
}

@end
