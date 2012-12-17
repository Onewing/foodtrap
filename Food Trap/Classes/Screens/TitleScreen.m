//
//  TitleScreen.m
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "TitleScreen.h"
#import "SplashScreen.h"
@implementation TitleScreen


-(void)update:(CADisplayLink *)displayLink {
    [super update:displayLink];
}

-(IBAction)showTitle {
    NSLog(@"Touch");
    SplashScreen *vc = [[SplashScreen alloc] init];
    [[Game sharedGame] show:vc];
}

@end
