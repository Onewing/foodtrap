//
//  ShipSelectionScreen.m
//  Food Trap
//
//  Created by Steven Silvey on 2/18/13.
//  Copyright (c) 2013 Rockfish. All rights reserved.
//

#import "ShipSelectionScreen.h"
#import "LevelSelectionScreen.h"


@interface ShipSelectionScreen ()

@end

@implementation ShipSelectionScreen

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark IBActions

-(IBAction)openLevelSelector {
    NSLog(@"Touch");
    LevelSelectionScreen *vc = [[LevelSelectionScreen alloc] init];
    [[Game sharedGame] show:vc];
    
    
}




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
    
    [self.scrollLayer setContentSize:self.scrollContent.frame.size];
    [self.scrollLayer addSubview:self.scrollContent];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
