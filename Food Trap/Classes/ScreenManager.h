//
//  ScreenManager.h
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Screen.h"


@interface ScreenManager : NSObject
+(ScreenManager *) sharedScreenManager;


-(NSArray *)activeScreens;
-(void)addScreen:(Screen *)screen;
-(void)addToDisplayArea:(UIView *)something;
-(void)setDisplayArea:(UIView *)_displayArea;

@end
