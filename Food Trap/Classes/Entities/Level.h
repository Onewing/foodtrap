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
#import "Animal.h"

typedef enum levelState {
    PAUSED = 0,
    PLAYING,
    COMPLETED
} LEVELSTATE;

@interface Level : Screen <EntityDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *viewTileLayer;
@property (nonatomic, strong) IBOutlet UIView *viewAnimalLayer;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollLayer;

@property (nonatomic, strong) NSMutableArray *tiles;
@property (nonatomic, strong) NSMutableArray *animals;
@property (nonatomic, assign) BOOL levelComplete;
@property (nonatomic, assign) LEVELSTATE state;

@property (nonatomic, strong) Animal *animalSelected;

@end
