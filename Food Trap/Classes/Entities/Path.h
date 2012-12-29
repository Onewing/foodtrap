//
//  Path.h
//  Food Trap
//
//  Created by Steven Silvey on 12/22/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Tile;
@interface Path : NSObject

@property (nonatomic, strong) Tile *tile;

-(id)initWithTile:(Tile *)tile;



+(BOOL)openNorth:(int)tag;
+(BOOL)openSouth:(int)tag;
+(BOOL)openEast:(int)tag;
+(BOOL)openWest:(int)tag;

@end
