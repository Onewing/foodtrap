//
//  Tile.m
//  Food Trap
//
//  Created by Steven Silvey on 12/22/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "Tile.h"

@implementation Tile

-(NSString *)description {
    return [[NSString alloc] initWithFormat:@"\nPosition: (%f,%f)\nNorth:%@\nSouth:%@\nEast:%@\nWest:%@\n",
            self.frame.origin.x/TILEW, self.frame.origin.y/TILEH,
            self.north.tile == nil ? @"None" : @"Yes",
            self.south.tile == nil ? @"None" : @"Yes",
            self.east.tile == nil ? @"None" : @"Yes",
            self.west.tile == nil ? @"None" : @"Yes"];
    
}

-(void)setup:(int)tag {
    UIImageView *imgview = (UIImageView *)self;
    switch(tag) {
        case 1:
            imgview.image = [UIImage imageNamed:@"wall1.png"];

            break;
        default:
            imgview.image = [UIImage imageNamed:@"wall10.png"];
            break;
    }
}

-(id)init {
    if(self = [super init]) {
        self.processed = NO;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
-(BOOL)isAdjacent:(Tile *)tile {
    if (self.north.tile == tile || self.south.tile == tile || self.west.tile == tile || self.east.tile == tile) {
        return YES;
    }
    
    return NO;
}

-(CGPoint)locationPoint {
    return CGPointMake(self.frame.origin.x, self.frame.origin.y);
}

-(void)renderWalls {
//    if(![Path openNorth:self.tag]) {
//        UIImageView *wall = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wall2.png"]];
//        [wall setFrame:self.frame];
//        [wall setBackgroundColor:[UIColor clearColor]];
//        [wall setOpaque:NO];
//        [self.superview addSubview:wall];
//    }
}



@end
