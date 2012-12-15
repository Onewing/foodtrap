//
//  Game.h
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameViewController.h"

@interface Game : NSObject
+(Game *) sharedGame;

@property (nonatomic, strong) GameViewController *screenManager;

-(void)setup;//:(UIView *)withScreen;
-(void)show:(Screen *)screen;
@end
