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
    for(Animal *animal in self.animals) {
        [animal update:displayLink];
    }
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

-(void)setAnimalTile:(Animal *)animal {
    Tile *location = (Tile *)[self.viewTileLayer hitTest:CGPointMake(animal.frame.origin.x+16, animal.frame.origin.y+16) withEvent:nil];
    if ([location class] == [Tile class]) {
        animal.tileLocation = location;
    }
    else {
        NSLog(@"Could not find animal's location!");
    }
}

-(void)processAnimal:(Animal *)animal {
    [self setAnimalTile:animal];
    animal.img = [[animal subviews] objectAtIndex:0];
    animal.delegate = self;
    [self.animals addObject:animal];
}

-(void)entityTouched:(NSNotification *)notification {
//    NSLog(@"Entity Touched:  %@", [notification userInfo]);
    if(self.animalSelected.moving) {
        return;
    }
    
    Entity *e = [[notification userInfo] objectForKey:@"entity"];
    if ([e isKindOfClass:[Animal class]]) {
        NSLog(@"touched an animal!");
        if(self.animalSelected != nil)
            [self.animalSelected.selected removeFromSuperview];
        self.animalSelected = (Animal *)e;
        UIImageView *imgSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected.png"]];
        [self.animalSelected addSubview:imgSelected];
        self.animalSelected.selected = imgSelected;
    }
    if([e isKindOfClass:[Tile class]]) {
        NSLog(@"touched a tile!");
        if(self.animalSelected != nil) {
            /// Move animal if tapped a tile adjacent to selected animal.
            Tile *tileSelected = (Tile *) e;
            
            if ([tileSelected isAdjacent:self.animalSelected.tileLocation]) {
                NSLog(@"Is adjacent!");
                [self.animalSelected moveToLocation:[tileSelected locationPoint] speed:128.0f];
            }
            else {
                [self.animalSelected.selected removeFromSuperview];
                self.animalSelected = nil;
            }
        }
        
        
        
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark EntityDelegate Methods
-(void)movedToLocation:(Entity *)entity {
    if (entity == self.animalSelected) {
        [self setAnimalTile:self.animalSelected];
    }
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark View Life Cycle


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
