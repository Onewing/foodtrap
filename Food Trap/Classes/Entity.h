//
//  FTEntity.h
//  Food Trap
//
//  Created by Steven Silvey on 11/24/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTTile.h"

@interface Entity : UIView

-(void)setLocation:(CGPoint)pt;
-(void)moveTo:(FTTile *)tile;

-(void)update:(CADisplayLink *)displayLink;

-(CGFloat)relativeX:(CGFloat)x;
-(CGFloat)relativeY:(CGFloat)y;
-(CGRect)relativeRect:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h;


@end
