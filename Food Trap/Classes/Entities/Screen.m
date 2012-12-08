//
//  Screen.m
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "Screen.h"
#import "ScreenManager.h"

@implementation Screen

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods

-(void)setup {
    
}

-(void)update:(CADisplayLink *)displayLink {
    [super update:displayLink];
}

-(void)display:(UIView *)something {
    [[ScreenManager sharedScreenManager] addToDisplayArea:something];
}


@end
