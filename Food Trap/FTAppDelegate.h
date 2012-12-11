//
//  FTAppDelegate.h
//  Food Trap
//
//  Created by Steven Silvey on 11/24/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameViewController;

@interface FTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GameViewController *viewController;

@end
