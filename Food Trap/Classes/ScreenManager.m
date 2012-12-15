//
//  ScreenManager.m
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "ScreenManager.h"

@interface ScreenManager ()

@property (nonatomic, strong) NSArray *screens;

@end




@implementation ScreenManager
static UIView *displayArea;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Singleton setup

static ScreenManager *sharedScreenManager = nil;
+(ScreenManager *)sharedScreenManager {
    @synchronized(self) {
        if(sharedScreenManager == nil) {
            sharedScreenManager = [[self alloc] init];
        }
    }
    return sharedScreenManager;
}

+(id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if(sharedScreenManager == nil) {
            sharedScreenManager = [super allocWithZone:zone];
            return sharedScreenManager;
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
-(NSArray *)activeScreens {
    NSMutableArray *activeScreens = [NSMutableArray array];
    for(Screen *scr in self.screens) {
        if (scr.active) {
            [activeScreens addObject:scr];
        }
    }
    return activeScreens;
}

-(void)addScreen:(Screen *)screen {
    if(screen == nil) {
        NSLog(@"Attempting to add 'nil' to list of screens");
        return;
    }
    
    NSMutableArray *screens = [NSMutableArray arrayWithArray:self.screens];
    [screens addObject:screen];
    self.screens = screens;
    
    if(screen.active) {
//        [self addToDisplayArea:screen];
    }
}

-(void)addToDisplayArea:(UIView *)something {
    if(displayArea == nil) {
        NSLog(@"The display area has not been set yet!");
        return;
    }
    [displayArea addSubview:something];
}

-(void)setDisplayArea:(UIView *)_displayArea {
    displayArea = _displayArea;
}

-(void)showScreen:(Screen *)screen {
//    [screen setLocation:CGPointMake(SCREEN_W, 0)];
//    screen.active = YES;
//    [self addScreen:screen];
    
}

@end
