//
//  Animal.h
//  Food Trap
//
//  Created by Steven Silvey on 1/5/13.
//  Copyright (c) 2013 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "Tile.h"

@interface Animal : Entity
@property (nonatomic, strong) Tile *tileLocation;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UIImageView *selected;
@property (nonatomic, assign) BOOL alive;

@property (nonatomic, strong) NSArray *prey;

-(void)addPrey:(Class)c;
-(void)eat;

-(void)setup;
@end
