//
//  Level.m
//  Food Trap
//
//  Created by Steven Silvey on 12/22/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "Level.h"
#import "Tile.h"
#import "Path.h"
#import "Animal.h"

@implementation Level


-(void)update:(CADisplayLink *)displayLink {
    [super update:displayLink];
}




-(Tile *)processTile:(Tile *)tile {
    if(tile == nil || tile.hidden || tile.tag == 0 || tile.tag == TAG_WALL) {
        return nil;
    }
    /// North Tiles
    if(!tile.north && [Path openNorth:tile.tag]) {
        Tile *north = (Tile *)[self.viewTileLayer hitTest:CGPointMake(tile.frame.origin.x, tile.frame.origin.y-30) withEvent:nil];
        if([north class] == [Tile class] && north && north.tag != TAG_WALL) {
            tile.north = [[Path alloc] initWithTile:north];
            north.south = [[Path alloc] initWithTile:tile];
        }
        
    }
    
    /// South Tiles
    if(!tile.south && [Path openSouth:tile.tag]) {
        Tile *south = (Tile *)[self.viewTileLayer hitTest:CGPointMake(tile.frame.origin.x, tile.frame.origin.y+33) withEvent:nil];
        if([south class] == [Tile class] && south && south.tag != TAG_WALL) {
            tile.south = [[Path alloc] initWithTile:south];
            south.north = [[Path alloc] initWithTile:tile];
        }
    }
    
    /// West Tiles
    if(!tile.west && [Path openWest:tile.tag]) {
        Tile *west = (Tile *)[self.viewTileLayer hitTest:CGPointMake(tile.frame.origin.x - 30, tile.frame.origin.y) withEvent:nil];
        if([west class] == [Tile class] && west && west.tag != TAG_WALL) {
            tile.west = [[Path alloc] initWithTile:west];
            west.east = [[Path alloc] initWithTile:tile];
        }
    }
    
    /// East Tiles
    if(!tile.east && [Path openEast:tile.tag]){
        Tile *east = (Tile *)[self.viewTileLayer hitTest:CGPointMake(tile.frame.origin.x + 33, tile.frame.origin.y) withEvent:nil];
        if([east class] == [Tile class] && east && east.tag != TAG_WALL) {
            tile.east = [[Path alloc] initWithTile:east];
            east.west = [[Path alloc] initWithTile:tile];
        }
    }
    [self.tiles addObject:tile];
    return tile;
}

-(void)processAnimal:(Animal *)animal {
    Tile *location = (Tile *)[self.viewTileLayer hitTest:CGPointMake(animal.frame.origin.x+16, animal.frame.origin.y+16) withEvent:nil];
    if ([location class] == [Tile class]) {
        animal.location = location;
    }
    else {
        NSLog(@"Could not find animal's location!");
    }
    animal.img = [[animal subviews] objectAtIndex:0];
    [self.animals addObject:animal];
}

-(void)entityTouched:(NSNotification *)notification {
//    NSLog(@"Entity Touched:  %@", [notification userInfo]);
    Entity *e = [[notification userInfo] objectForKey:@"entity"];
    if ([e isKindOfClass:[Animal class]]) {
        NSLog(@"touched an animal!");
        self.animalSelected = (Animal *)e;
        UIImageView *imgSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected.png"]];
        [self.animalSelected addSubview:imgSelected];
        self.animalSelected.selected = imgSelected;
    }
    if([e isKindOfClass:[Tile class]]) {
        NSLog(@"touched a tile!");
        [self.animalSelected.selected removeFromSuperview];
        self.animalSelected = nil;
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *t = [[event allTouches] anyObject];
    if(self.viewAnimalLayer == t.view) {
        /// The "viewAnimalLayer" will capture the touch, so we need to manually pass it on to the next layer, viewTileLayer
        CGPoint loc = [t locationInView:t.view];
        UIView *touch = [self.viewTileLayer hitTest:loc withEvent:nil];
        if ([touch isKindOfClass:[Entity class]]) {
            [self entityTouched:[NSNotification notificationWithName:@"EntityTouched" object:nil userInfo:[NSDictionary dictionaryWithObject:touch forKey:@"entity"]]];
        }
    }
}


-(void)viewDidLoad {
    [super viewDidLoad];
    self.tiles = [NSMutableArray array];
    self.animals = [NSMutableArray array];
    for(Tile *tile in [self.viewTileLayer subviews]) {
        [self processTile:tile];
    }
    for(Tile *tile in self.tiles) {
        [tile.img setHidden:NO];
    }
    
    for(Animal *animal in [self.viewAnimalLayer subviews]) {
        [self processAnimal:animal];
    }
    NSLog(@"Tiles: %@", self.tiles);
    NSLog(@"Animals:  %@", self.animals);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(entityTouched:) name:@"EntityTouched" object:nil];
}

-(void)destroy {
    [[NSNotificationCenter defaultCenter] removeObserver:@"EntityTouched"];
}

-(void)viewDidUnload {
    [super viewDidUnload];
    [self destroy];
}

-(void)dealloc {
    [self destroy];
}
@end
