//
//  Tile.h
//  Food Trap
//
//  Created by Steven Silvey on 12/22/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "Path.h"

#define TAG_WALL_WEST               1
#define TAG_WALL_NORTH              2
#define TAG_WALL_EAST               3
#define TAG_WALL_SOUTH              4
#define TAG_WALL_NORTHWEST          5
#define TAG_WALL_NORTHEAST          6
#define TAG_WALL_SOUTHEAST          7
#define TAG_WALL_SOUTHWEST          8
#define TAG_GROUND                  9
#define TAG_WALL                    10

@interface Tile : Entity

@property (nonatomic, strong) Path *north, *south, *west, *east;




@end
