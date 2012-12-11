//
//  TitleScreen.m
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "TitleScreen.h"

@implementation TitleScreen

-(void)setup {
    [super setup];
    UIView *testing = [[UIView alloc] initWithFrame:[self relativeRect:0 y:0 w:320 h:480]];
    [testing setBackgroundColor:[UIColor blueColor]];
    [self addSubview:testing];
    
}

-(void)update:(CADisplayLink *)displayLink {
    [super update:displayLink];
}


@end
