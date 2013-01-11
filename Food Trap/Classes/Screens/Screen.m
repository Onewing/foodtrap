//
//  Screen.m
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "Screen.h"


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
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods


-(void)update:(CADisplayLink *)displayLink {
    
}

-(void)display:(UIView *)something {
 
}


@end
