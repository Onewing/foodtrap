//
//  GameViewController.m
//  Food Trap
//
//  Created by Steven Silvey on 11/25/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "GameViewController.h"
#import "ScreenManager.h"
#import <QuartzCore/QuartzCore.h>


@interface GameViewController ()
@property (nonatomic, strong) UIView *testing;
@end

@implementation GameViewController


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.splash = [[SplashScreen alloc] init];
    self.splash.active = YES;
    [self.view addSubview:self.splash.view];
    [[ScreenManager sharedScreenManager] addScreen:self.splash];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)show:(Screen *)scr {
    [self.splash.view removeFromSuperview];
    self.titleScr = [[TitleScreen alloc] init];
    [self.view addSubview:self.titleScr.view];
}

@end
