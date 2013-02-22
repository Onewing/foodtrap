//
//  ShipSelectionScreen.h
//  Food Trap
//
//  Created by Steven Silvey on 2/18/13.
//  Copyright (c) 2013 Rockfish. All rights reserved.
//

#import "Screen.h"

@interface ShipSelectionScreen : Screen <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *scrollContent;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollLayer;

-(IBAction)openLevelSelector;

@end
