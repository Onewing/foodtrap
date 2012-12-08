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
    return self.screens;
}

-(void)addScreen:(Screen *)screen {
    if(screen == nil) {
        NSLog(@"Attempting to add 'nil' to list of screens");
        return;
    }
    
    NSMutableArray *screens = [NSMutableArray arrayWithArray:self.screens];
    [screens addObject:screen];
    self.screens = screens;
}

@end
