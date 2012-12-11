//
//  GameViewController.m
//  Food Trap
//
//  Created by Steven Silvey on 11/25/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "GameViewController.h"
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
    
    Game *game = [Game sharedGame];
    [game setup:self.view];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
