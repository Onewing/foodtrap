//
//  Tile.m
//  Food Trap
//
//  Created by Steven Silvey on 12/22/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "Tile.h"

@implementation Tile

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

@end
