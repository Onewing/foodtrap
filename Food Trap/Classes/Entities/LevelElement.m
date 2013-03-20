//
//  LevelElement.m
//  Food Trap
//
//  Created by Steven Silvey on 3/20/13.
//  Copyright (c) 2013 Rockfish. All rights reserved.
//

#import "LevelElement.h"

@implementation LevelElement


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Object Life Cycle
-(void)setup {
    self.alive = YES;
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
