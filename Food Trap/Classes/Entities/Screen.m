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

@synthesize active = _active;

-(id)init {
    if(self = [super init]) {
        self.active = NO;
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"touch");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods

-(void)setup {
    [self setFrame:CGRectMake(0, 0, 320, 480)];
    
}

-(void)update:(CADisplayLink *)displayLink {
    [super update:displayLink];
}

-(void)display:(UIView *)something {
    [[ScreenManager sharedScreenManager] addToDisplayArea:something];
}


@end
