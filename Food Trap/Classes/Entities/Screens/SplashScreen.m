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

-(void)setup {
    [super setup];
    self.testing = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 20, 20)];
    [self.testing setBackgroundColor:[UIColor redColor]];
    [self display:self.testing];

}

-(void)update:(CADisplayLink *)displayLink {
    [super update:displayLink];
    CGFloat pixelsPerSecond = 100;
    CGFloat timeElasped = displayLink.duration * displayLink.frameInterval;
    CGFloat actualDistance = pixelsPerSecond * timeElasped;
    [self.testing setFrame:CGRectMake(self.testing.frame.origin.x + actualDistance, self.testing.frame.origin.y, 20, 20)];

    
}

@end
