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
#import "Mouse.h"
#import "Snake.h"
#import "SafeZone.h"

#import "LevelLayer.h"
@implementation Level


-(void)update:(CADisplayLink *)displayLink {
    [super update:displayLink];
    if(!self.animalSelected.alive) {
        self.animalSelected = nil;
    }
    for(Animal *animal in self.animals) {
        if(animal.alive) {
            [animal update:displayLink];
        }
    }
}




-(Tile *)processTile:(Tile *)tile {
    if(tile == nil || tile.hidden || tile.tag == 0 || tile.tag == TAG_WALL) {
        return nil;
    }

    /// Add the wall graphics into the layer
    [tile renderWalls];
    
    /// North Tiles
    if(!tile.north && [Path openNorth:tile.tag]) {
        Tile *north = (Tile *)[self.viewTileLayer hitTest:CGPointMake(tile.frame.origin.x, tile.frame.origin.y-TILEH) withEvent:nil];
        if([north isKindOfClass:[Tile class]] && north && north.tag != TAG_WALL) {
            tile.north = [[Path alloc] initWithTile:north];
            north.south = [[Path alloc] initWithTile:tile];
        }
        
    }
    
    /// South Tiles
    if(!tile.south && [Path openSouth:tile.tag]) {
        Tile *south = (Tile *)[self.viewTileLayer hitTest:CGPointMake(tile.frame.origin.x, tile.frame.origin.y+TILEH) withEvent:nil];
        if([south isKindOfClass:[Tile class]] && south && south.tag != TAG_WALL) {
            tile.south = [[Path alloc] initWithTile:south];
            south.north = [[Path alloc] initWithTile:tile];
        }
    }
    
    /// West Tiles
    if(!tile.west && [Path openWest:tile.tag]) {
        Tile *west = (Tile *)[self.viewTileLayer hitTest:CGPointMake(tile.frame.origin.x - TILEW, tile.frame.origin.y) withEvent:nil];
        if([west isKindOfClass:[Tile class]] && west && west.tag != TAG_WALL) {
            tile.west = [[Path alloc] initWithTile:west];
            west.east = [[Path alloc] initWithTile:tile];
        }
    }
    
    /// East Tiles
    if(!tile.east && [Path openEast:tile.tag]){
        Tile *east = (Tile *)[self.viewTileLayer hitTest:CGPointMake(tile.frame.origin.x + TILEW, tile.frame.origin.y) withEvent:nil];
        if([east isKindOfClass:[Tile class]] && east && east.tag != TAG_WALL) {
            tile.east = [[Path alloc] initWithTile:east];
            east.west = [[Path alloc] initWithTile:tile];
        }
    }
    [self.tiles addObject:tile];
    return tile;
}

-(void)setAnimalTile:(Animal *)animal {
    [animal setUserInteractionEnabled:NO];
    Tile *location = (Tile *)[self.viewTileLayer hitTest:CGPointMake(animal.frame.origin.x+16, animal.frame.origin.y+16) withEvent:nil];
    [animal setUserInteractionEnabled:YES];
    if ([location isKindOfClass:[Tile class]]) {
        animal.tileLocation.animal = nil;
        
        location.animal = animal;
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

-(void)animalTouched:(Animal *)touchedAnimal {
    if (touchedAnimal.alive) {
        if(self.animalSelected != nil)
            [self.animalSelected.selected removeFromSuperview];
        self.animalSelected = touchedAnimal;
        UIImageView *imgSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected.png"]];
        [imgSelected setFrame:CGRectMake(0, 0, TILEW, TILEH)];
        [self.animalSelected addSubview:imgSelected];
        self.animalSelected.selected = imgSelected;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Notification Receivers

-(void)entityTouched:(NSNotification *)notification {
    
    if(self.animalSelected.moving) {
        return;
    }
    
    Entity *e = [[notification userInfo] objectForKey:@"entity"];
    if ([e isKindOfClass:[Animal class]]) {
        NSLog(@"touched an animal!");
        [self animalTouched:(Animal *)e];
        
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



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Main Level Logic
-(void)layerTouched:(NSNotification *)notification {
    if(self.animalSelected.moving) {
        return;
    }
    
    UITouch *l = [[notification userInfo] objectForKey:@"layer"];
    if(self.state == PLAYING) {
        if(self.viewAnimalLayer == l.view) {
            /// The "viewAnimalLayer" will capture the touch, so we need to manually pass it on to the next layer, viewTileLayer
            CGPoint loc = [l locationInView:l.view];
            UIView *touch = [self.viewTileLayer hitTest:loc withEvent:nil];
            if ([touch isKindOfClass:[Entity class]]) {
                [self entityTouched:[NSNotification notificationWithName:@"EntityTouched" object:nil userInfo:[NSDictionary dictionaryWithObject:touch forKey:@"entity"]]];
            }
        }
    }
}


-(void)animalLogic {
    if (self.state == PLAYING) {
        /// The level is complete, unless anything fails to meet the criteria in the loop below
        BOOL levelComplete = YES;
        
        for(Animal *animal in self.animals) {
            if(animal.alive) {
                [animal eat];
                
                if ([animal.tileLocation class] != [SafeZone class]) {
                    levelComplete = NO;
                }
            }            
            
        }
        self.levelComplete = levelComplete;
        
        if(self.levelComplete) {
            self.state = COMPLETED;
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark EntityDelegate Methods
-(void)movedToLocation:(Entity *)entity {
    if([entity isKindOfClass:[Animal class]]) {
        
        [self setAnimalTile:(Animal *)entity];
    
        /// Run all the game rules to see if anything should happen now that the board has changed
        [self animalLogic];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIScrollView Delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [[self.scrollLayer subviews] objectAtIndex:0];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIView *subView = [scrollView.subviews objectAtIndex:0];
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
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
        [self.viewTileLayer sendSubviewToBack:tile];
    }
    
    for(Animal *animal in [self.viewAnimalLayer subviews]) {
        [self processAnimal:animal];
    }
    NSLog(@"Tiles: %@", self.tiles);
    NSLog(@"Animals:  %@", self.animals);
    
    self.levelComplete = NO;
    self.state = PLAYING;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(entityTouched:) name:@"EntityTouched" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layerTouched:) name:@"LayerTouched" object:nil];
    
    
    /// Setup the zooming/scrolling stuff
    [self.scrollLayer setContentSize:CGSizeMake(1640, 480)];
    [self.scrollLayer setMaximumZoomScale:1.5f];
    [self.scrollLayer setMinimumZoomScale:0.5f];
    [self.scrollLayer setZoomScale:1.0f];

     
}

-(void)destroy {
    [[NSNotificationCenter defaultCenter] removeObserver:@"EntityTouched"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"LayerTouched"];
}

-(void)viewDidUnload {
    [super viewDidUnload];
    [self destroy];
}

-(void)dealloc {
    [self destroy];
}
@end
