//
//  GameViewController.m
//  Food Trap
//
//  Created by Steven Silvey on 11/25/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "GameViewController.h"
#import "SplashScreen.h"
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
    
    self.activeScreen = [[SplashScreen alloc] init];
    self.activeScreen.active = YES;
    [self.view addSubview:self.activeScreen.view];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)show:(Screen *)scr {
    self.incoming = scr;
    
    
    [self.activeScreen viewWillDisappear:YES];
    [self.incoming viewWillAppear:YES];
    
    [self.activeScreen.view removeFromSuperview];
    [self.view addSubview:self.incoming.view];
    
    [self.activeScreen viewDidDisappear:YES];
    [self.incoming viewDidAppear:YES];
    
    self.activeScreen = scr;
    self.incoming = nil;
    
}

@end
