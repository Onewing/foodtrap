//
//  FTEntity.h
//  Food Trap
//
//  Created by Steven Silvey on 11/24/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTTile.h"

@interface Entity : NSObject

@property (nonatomic, assign) NSInteger x,y;

-(void)moveTo:(FTTile *)tile;

-(void)update:(CADisplayLink *)displayLink;

@end
