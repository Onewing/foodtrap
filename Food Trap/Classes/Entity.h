//
//  FTEntity.h
//  Food Trap
//
//  Created by Steven Silvey on 11/24/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTTile.h"

@class Entity;
@protocol EntityDelegate <NSObject>

-(void)movedToLocation:(Entity *)entity;

@end


@interface Entity : UIView

@property (nonatomic, assign) CGPoint destination;
@property (nonatomic, assign) CGFloat ax, ay;
@property (nonatomic, assign) CGFloat distToDest;
@property (nonatomic, assign) BOOL moving;
@property (nonatomic, assign) id<EntityDelegate> delegate;

-(void)setLocation:(CGPoint)pt;
-(void)moveTo:(FTTile *)tile;
-(void)moveToLocation:(CGPoint)pt speed:(CGFloat)pps;

-(void)update:(CADisplayLink *)displayLink;

-(CGFloat)relativeX:(CGFloat)x;
-(CGFloat)relativeY:(CGFloat)y;
-(CGRect)relativeRect:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h;


@end
