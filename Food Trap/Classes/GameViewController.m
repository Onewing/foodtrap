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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)gameUpdate:(CADisplayLink *)displayLink {
    NSLog(@"test");
    CGFloat pixelsPerSecond = 100;
    CGFloat timeElasped = displayLink.duration * displayLink.frameInterval;
    CGFloat actualDistance = pixelsPerSecond * timeElasped;
    [self.testing setFrame:CGRectMake(self.testing.frame.origin.x + actualDistance, self.testing.frame.origin.y, 20, 20)];
}

-(void)gameRender {
    
}

-(void)gameLoop:(CADisplayLink *)displayLink {
    [self gameUpdate:displayLink];
    [self gameRender];
    NSLog(@"time:  %f", displayLink.duration);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    BOOL running = NO;
    self.testing = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 20, 20)];
    [self.testing setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.testing];
    if (!running)
	{
		if (YES) //displayLinkSupported)
		{
            CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop:)];
            [displayLink setFrameInterval:1];   // 1 = 60fps, 2 - 30fps
            [displayLink addToRunLoop:[NSRunLoop mainRunLoop]
                              forMode:NSRunLoopCommonModes];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
