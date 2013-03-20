//
//  Eagle.m
//  Food Trap
//
//  Created by Steven Silvey on 2/15/13.
//  Copyright (c) 2013 Rockfish. All rights reserved.
//

#import "Eagle.h"
#import "Snake.h"
#import "Mouse.h"

@implementation Eagle


-(void)setup {
    [super setup];
    [self addPrey:[Mouse class]];
    [self addPrey:[Snake class]];
}

-(id)init {
    if(self = [super init]) {
        [self setup];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(LevelElement *)findNorthernAnimal {
    Tile *tile = self.tileLocation.north.tile;
    while(tile != nil && tile.tag != TAG_WALL && tile.element == nil) {
        tile = tile.north.tile;
    }
    if(tile.element != nil) {
        return tile.element;
    }
    
    return nil;
}

-(LevelElement *)findSouthernAnimal {
    Tile *tile = self.tileLocation.south.tile;
    while(tile != nil && tile.tag != TAG_WALL && tile.element == nil) {
        tile = tile.south.tile;
    }
    if(tile.element != nil) {
        return tile.element;
    }
    
    return nil;
}

-(LevelElement *)findWesternAnimal {
    Tile *tile = self.tileLocation.west.tile;
    while(tile != nil && tile.tag != TAG_WALL && tile.element == nil) {
        tile = tile.west.tile;
    }
    if(tile.element != nil) {
        return tile.element;
    }
    
    return nil;
}

-(LevelElement *)findEasternAnimal {
    Tile *tile = self.tileLocation.east.tile;
    while(tile != nil && tile.tag != TAG_WALL && tile.element == nil) {
        tile = tile.east.tile;
    }
    if(tile.element != nil) {
        return tile.element;
    }
    
    return nil;
}



-(NSArray *)findElements {
    NSMutableArray *adjAnimals = [NSMutableArray array];
    
    LevelElement *northernAnimal = [self findNorthernAnimal];
    if(northernAnimal != nil) {
        [adjAnimals addObject:northernAnimal];
    }
    
    LevelElement *southernAnimal = [self findSouthernAnimal];
    if(southernAnimal != nil) {
        [adjAnimals addObject:southernAnimal];
    }
    
    LevelElement *westernAnimal = [self findWesternAnimal];
    if(westernAnimal != nil) {
        [adjAnimals addObject:westernAnimal];
    }
    
    LevelElement *easternAnimal = [self findEasternAnimal];
    if(easternAnimal != nil) {
        [adjAnimals addObject:easternAnimal];
    }
    
    
    return adjAnimals;
}


@end
