//
//  FTAppDelegate.m
//  Food Trap
//
//  Created by Steven Silvey on 11/24/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "FTAppDelegate.h"
#import "SplashScreen.h"
#import "GameViewController.h"
#import "FTViewController.h"

@implementation FTAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	self.viewController = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
//    self.viewController.active = YES;
//    [[ScreenManager sharedScreenManager] addScreen:self.viewController];
    Game *game = [Game sharedGame];
    [game setup];
    game.screenManager = self.viewController;
    
	// Do any additional setup after loading the view.
    BOOL running = NO;
    //    self.testing = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 20, 20)];
    //    [self.testing setBackgroundColor:[UIColor redColor]];
    //    [self.view addSubview:self.testing];
    if (!running)
	{
#warning "Need to review this!  See bookmarks for where I got this code"
		if (YES) //displayLinkSupported)
		{
            CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:game selector:@selector(gameLoop:)];
            [displayLink setFrameInterval:1];   // 1 = 60fps, 2 - 30fps
            [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        }
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
