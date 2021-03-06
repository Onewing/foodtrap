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

-(NSArray *)findElements {
    NSMutableArray *adjAnimals = [NSMutableArray array];
    if(self.tileLocation.north.tile.element != nil) {
        [adjAnimals addObject:self.tileLocation.north.tile.element];
    }
    if(self.tileLocation.south.tile.element != nil) {
        [adjAnimals addObject:self.tileLocation.south.tile.element];
    }
    if(self.tileLocation.west.tile.element != nil) {
        [adjAnimals addObject:self.tileLocation.west.tile.element];
    }
    if(self.tileLocation.east.tile.element != nil) {
        [adjAnimals addObject:self.tileLocation.east.tile.element];
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
    NSArray *animalsNearby = [self findElements];
    for(Animal *animal in animalsNearby) {
        if([self isPrey:animal]) {
            /// Eat the animal
            NSLog(@"Eat it!");
            [self moveToLocation:[animal.tileLocation locationPoint] speed:128.0f];
            
            /// Kill the animal.
            [animal removeFromSuperview];
            animal.alive = NO;
            animal.tileLocation.element = nil;
            
            /// Only eat one thing at a time
            break;
        }
    }
}


@end
