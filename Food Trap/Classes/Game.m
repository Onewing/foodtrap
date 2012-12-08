//
//  Game.m
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "Game.h"
#import <QuartzCore/QuartzCore.h>

@implementation Game

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Singleton setup

static Game *sharedGame = nil;
+(Game *)sharedGame {
    @synchronized(self) {
        if(sharedGame == nil) {
            sharedGame = [[self alloc] init];
        }
    }
    return sharedGame;
}

+(id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if(sharedGame == nil) {
            sharedGame = [super allocWithZone:zone];
            return sharedGame;
        }
    }
    return nil;
}

-(id)copyWithZone:(NSZone *)zone {
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods

-(void)gameUpdate:(CADisplayLink *)displayLink {
//    CGFloat pixelsPerSecond = 100;
//    CGFloat timeElasped = displayLink.duration * displayLink.frameInterval;
//    CGFloat actualDistance = pixelsPerSecond * timeElasped;
//    [self.testing setFrame:CGRectMake(self.testing.frame.origin.x + actualDistance, self.testing.frame.origin.y, 20, 20)];
}

-(void)gameRender {
    
}

-(void)gameLoop:(CADisplayLink *)displayLink {
    [self gameUpdate:displayLink];
    [self gameRender];
    NSLog(@"time:  %f", displayLink.duration);
}


@end
