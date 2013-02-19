//
//  Animal.m
//  Food Trap
//
//  Created by Steven Silvey on 1/5/13.
//  Copyright (c) 2013 Rockfish. All rights reserved.
//

#import "Animal.h"

@implementation Animal

-(NSString *)description {
    if(self.alive)
        return [[NSString alloc] initWithFormat:@"\%@ at Tile: %@", [self class], self.tileLocation];
    else
        return [[NSString alloc] initWithFormat:@"\%@ is no longer alive", [self class]];
    
}

-(void)addPrey:(Class)c {
    NSMutableArray *prey = [NSMutableArray arrayWithArray:self.prey];
    [prey addObject:[[NSString alloc] initWithFormat:@"%@", NSStringFromClass(c)]];
    self.prey = prey;
}

-(NSArray *)findAnimals {
    NSMutableArray *adjAnimals = [NSMutableArray array];
    if(self.tileLocation.north.tile.animal != nil) {
        [adjAnimals addObject:self.tileLocation.north.tile.animal];
    }
    if(self.tileLocation.south.tile.animal != nil) {
        [adjAnimals addObject:self.tileLocation.south.tile.animal];
    }
    if(self.tileLocation.west.tile.animal != nil) {
        [adjAnimals addObject:self.tileLocation.west.tile.animal];
    }
    if(self.tileLocation.east.tile.animal != nil) {
        [adjAnimals addObject:self.tileLocation.east.tile.animal];
    }

    return adjAnimals;
}

-(BOOL)isPrey:(Animal *)potentialPrey {
    for(NSString *prey in self.prey) {
        if([prey isEqualToString:NSStringFromClass([potentialPrey class])]) {
            return YES;
        }
    }
    return NO;
}


-(void)eat {
    NSArray *animalsNearby = [self findAnimals];
    for(Animal *animal in animalsNearby) {
        if([self isPrey:animal]) {
            /// Eat the animal
            NSLog(@"Eat it!");
            [self moveToLocation:[animal.tileLocation locationPoint] speed:128.0f];
            
            /// Kill the animal.
            [animal removeFromSuperview];
            animal.alive = NO;
            animal.tileLocation.animal = nil;
            
            /// Only eat one thing at a time
            break;
        }
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Object Life Cycle
-(void)setup {
    self.alive = YES;
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

@end
