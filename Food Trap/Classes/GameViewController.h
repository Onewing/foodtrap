//
//  GameViewController.h
//  Food Trap
//
//  Created by Steven Silvey on 11/25/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashScreen.h"
#import "TitleScreen.h"




@interface GameViewController : UIViewController

@property (nonatomic, strong) SplashScreen *splash;
@property (nonatomic, strong) TitleScreen *titleScr;

-(void)show:(Screen *)scr;

@end
