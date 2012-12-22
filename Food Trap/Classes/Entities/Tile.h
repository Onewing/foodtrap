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

@interface Tile : Entity

@property (nonatomic, strong) Path *north, *south, *west, *east;


@end
