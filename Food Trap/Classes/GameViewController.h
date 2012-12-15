//
//  GameViewController.h
//  Food Trap
//
//  Created by Steven Silvey on 11/25/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Screen.h"

@interface GameViewController : UIViewController

@property (nonatomic, strong) Screen *active;
@property (nonatomic, strong) Screen *incoming;

-(void)show:(Screen *)scr;

@end
