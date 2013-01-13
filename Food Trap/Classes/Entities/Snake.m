//
//  Snake.m
//  Food Trap
//
//  Created by Steven Silvey on 1/12/13.
//  Copyright (c) 2013 Rockfish. All rights reserved.
//

#import "Snake.h"
#import "Mouse.h"

@implementation Snake

-(void)setup {
    [super setup];
    [self addPrey:[Mouse class]];
}

-(id)init {
    if(self = [super init]) {
        [self setup];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
@end
