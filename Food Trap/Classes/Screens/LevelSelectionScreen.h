//
//  LevelSelectionScreen.h
//  Food Trap
//
//  Created by Steven Silvey on 2/21/13.
//  Copyright (c) 2013 Rockfish. All rights reserved.
//

#import "Screen.h"

@interface LevelSelectionScreen : Screen <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *scrollContent;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollLayer;

@end
