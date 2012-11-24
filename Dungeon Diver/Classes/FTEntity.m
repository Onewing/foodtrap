//
//  DDEntity.m
//  Food Trap
//
//  Created by Steven Silvey on 3/26/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "FTEntity.h"


@implementation FTEntity

@synthesize x=_x, y=_y;

-(void)setLocation:(FTTile *)tile {
	self.x = tile.x;
	self.y = tile.y;
}

-(void)setLocationWithParams:(NSDictionary *)params {
	[self setLocation:[params objectForKey:@"tile"]];
}

-(void)moveTo:(FTTile *)tile {
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDuration:0.1f];
	// Do yah animation
	[self.view setFrame:tile.view.frame];
	
	[UIView commitAnimations];
	
//	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:tile, @"tile", nil];
//	[NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(setLocationWithParams:) userInfo:params repeats:NO];
	[self performSelector:@selector(setLocation:) withObject:tile afterDelay:0.3f];
}

@end
