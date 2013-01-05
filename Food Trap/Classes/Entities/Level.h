//
//  Level.h
//  Food Trap
//
//  Created by Steven Silvey on 12/22/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "Screen.h"

@interface Level : Screen

@property (nonatomic, strong) IBOutlet UIView *viewTileLayer;
@property (nonatomic, strong) IBOutlet UIView *viewAnimalLayer;

@property (nonatomic, strong) NSMutableArray *tiles;
@property (nonatomic, strong) NSMutableArray *animals;

@end
