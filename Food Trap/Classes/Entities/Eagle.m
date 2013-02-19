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

-(Animal *)findNorthernAnimal {
    Tile *tile = self.tileLocation.north.tile;
    while(tile != nil && tile.tag != TAG_WALL && tile.animal == nil) {
        tile = tile.north.tile;
    }
    if(tile.animal != nil) {
        return tile.animal;
    }
    
    return nil;
}

-(Animal *)findSouthernAnimal {
    Tile *tile = self.tileLocation.south.tile;
    while(tile != nil && tile.tag != TAG_WALL && tile.animal == nil) {
        tile = tile.south.tile;
    }
    if(tile.animal != nil) {
        return tile.animal;
    }
    
    return nil;
}

-(Animal *)findWesternAnimal {
    Tile *tile = self.tileLocation.west.tile;
    while(tile != nil && tile.tag != TAG_WALL && tile.animal == nil) {
        tile = tile.west.tile;
    }
    if(tile.animal != nil) {
        return tile.animal;
    }
    
    return nil;
}

-(Animal *)findEasternAnimal {
    Tile *tile = self.tileLocation.east.tile;
    while(tile != nil && tile.tag != TAG_WALL && tile.animal == nil) {
        tile = tile.east.tile;
    }
    if(tile.animal != nil) {
        return tile.animal;
    }
    
    return nil;
}



-(NSArray *)findAnimals {
    NSMutableArray *adjAnimals = [NSMutableArray array];
    
    Animal *northernAnimal = [self findNorthernAnimal];
    if(northernAnimal != nil) {
        [adjAnimals addObject:northernAnimal];
    }
    
    Animal *southernAnimal = [self findSouthernAnimal];
    if(southernAnimal != nil) {
        [adjAnimals addObject:southernAnimal];
    }
    
    Animal *westernAnimal = [self findWesternAnimal];
    if(westernAnimal != nil) {
        [adjAnimals addObject:westernAnimal];
    }
    
    Animal *easternAnimal = [self findEasternAnimal];
    if(easternAnimal != nil) {
        [adjAnimals addObject:easternAnimal];
    }
    
    
    return adjAnimals;
}


@end
