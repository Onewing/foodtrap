//
//  Level.m
//  Food Trap
//
//  Created by Steven Silvey on 12/22/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "Level.h"
#import "Tile.h"

@implementation Level


-(void)update:(CADisplayLink *)displayLink {
    [super update:displayLink];
}



-(void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *tiles = [NSMutableArray array];
    for(Tile *tile in [self.viewTileLayer subviews]) {
        NSLog(@"%f", tile.frame.origin.x);
        UIImageView *img = (UIImageView *)tile;
        if ([img tag] != 0 && [img tag] != TAG_WALL) {
            NSLog(@"stop");
            UIView *v = [self.viewTileLayer hitTest:CGPointMake(tile.frame.origin.x, tile.frame.origin.y-30) withEvent:nil];
            NSLog(@"%d", v.tag);
        }
    }
    
}

@end
