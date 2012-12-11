//
//  Game.m
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "Game.h"
#import "ScreenManager.h"
#import "SplashScreen.h"
#import "TitleScreen.h"

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

-(void)setup:(UIView *)withScreen {
    [[ScreenManager sharedScreenManager] setDisplayArea:withScreen];
    
    SplashScreen *screen = [[SplashScreen alloc] init];
    [screen setup];
    screen.active = YES;
    [[ScreenManager sharedScreenManager] addScreen:screen];
    
    TitleScreen *screen2 = [[TitleScreen alloc] init];
    [screen2 setup];
    [screen2 setLocation:CGPointMake(SCREEN_W/2, 0)];
    [[ScreenManager sharedScreenManager] addScreen:screen2];
    
}


-(void)gameUpdate:(CADisplayLink *)displayLink {
    
    NSArray *screens = [[ScreenManager sharedScreenManager] activeScreens];
    for(Screen *screen in screens) {
        [screen update:displayLink];
    }
}

-(void)gameRender {
    
}

-(void)gameLoop:(CADisplayLink *)displayLink {
    [self gameUpdate:displayLink];
    [self gameRender];
//    NSLog(@"time:  %f", displayLink.duration);
}



@end
