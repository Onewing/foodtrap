//
//  Path.m
//  Food Trap
//
//  Created by Steven Silvey on 12/22/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "Path.h"
#import "Tile.h"

@implementation Path

-(id)initWithTile:(Tile *)tile {
    if(self=[super init]) {
        self.tile = tile;
    }
    return self;
}

+(BOOL)openNorth:(int)tag {
    if(tag != TAG_WALL_NORTH &&
       tag != TAG_WALL_NORTHEAST &&
       tag != TAG_WALL_NORTHWEST &&
       tag != TAG_WALL_NORTHEND) {
        return YES;
    }
    
    return NO;
}

+(BOOL)openSouth:(int)tag {
    if(tag != TAG_WALL_SOUTH &&
       tag != TAG_WALL_SOUTHEAST &&
       tag != TAG_WALL_SOUTHWEST &&
       tag != TAG_WALL_SOUTHEND) {
        return YES;
    }
    
    return NO;
}

+(BOOL)openEast:(int)tag {
    if(tag != TAG_WALL_EAST &&
       tag != TAG_WALL_NORTHEAST &&
       tag != TAG_WALL_SOUTHEAST &&
       tag != TAG_WALL_EASTEND) {
        return YES;
    }
    
    return NO;
}

+(BOOL)openWest:(int)tag {
    if(tag != TAG_WALL_WEST &&
       tag != TAG_WALL_NORTHWEST &&
       tag != TAG_WALL_SOUTHWEST &&
       tag != TAG_WALL_WESTEND) {
        return YES;
    }
    
    return NO;
}

@end
