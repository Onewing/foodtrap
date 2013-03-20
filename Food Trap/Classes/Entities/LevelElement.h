//
//  LevelElement.h
//  Food Trap
//
//  Created by Steven Silvey on 3/20/13.
//  Copyright (c) 2013 Rockfish. All rights reserved.
//

#import "Entity.h"
#import "Tile.h"

@interface LevelElement : Entity

@property (nonatomic, strong) Tile *tileLocation;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, assign) BOOL alive;
@property (nonatomic, strong) UIImageView *selected;

-(void)setup;

@end
