//
//  TitleScreen.m
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "TitleScreen.h"
#import "SplashScreen.h"
#import "Level.h"
#import "ShipSelectionScreen.h"

@implementation TitleScreen


-(void)update:(CADisplayLink *)displayLink {
    [super update:displayLink];
}

-(IBAction)showTitle {
    NSLog(@"Touch");
//    Level *vc = [[Level alloc] initWithNibName:@"Level2" bundle:[NSBundle mainBundle]];
//    [[Game sharedGame] show:vc];
    
    ShipSelectionScreen *vc = [[ShipSelectionScreen alloc] init];
    [[Game sharedGame] show:vc];
}

@end
