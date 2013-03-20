//
//  Animal.h
//  Food Trap
//
//  Created by Steven Silvey on 1/5/13.
//  Copyright (c) 2013 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "LevelElement.h"

@interface Animal : LevelElement





@property (nonatomic, strong) NSArray *prey;

-(void)addPrey:(Class)c;
-(void)eat;


@end
