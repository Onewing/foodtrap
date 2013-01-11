//
//  FTEntity.m
//  Food Trap
//
//  Created by Steven Silvey on 11/24/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "Entity.h"


@implementation Entity

//@synthesize x=_x, y=_y;

-(CGFloat)relativeX:(CGFloat)x {
    return self.frame.origin.x + x;
}

-(CGFloat)relativeY:(CGFloat)y {
    return self.frame.origin.y + y;
}

-(CGRect)relativeRect:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h {
    return CGRectMake([self relativeX:x], [self relativeY:y], w, h);
}

-(void)update:(CADisplayLink *)displayLink {
    CGFloat timeElasped = displayLink.duration * displayLink.frameInterval;
    CGFloat dx = self.ax * timeElasped;
    CGFloat dy = self.ay * timeElasped;
    [self setFrame:CGRectMake(self.frame.origin.x + dx, self.frame.origin.y + dy, self.frame.size.width, self.frame.size.height)];
 
    CGFloat dist = abs(self.frame.origin.x - self.destination.x) + abs(self.frame.origin.y - self.destination.y);
    if(dist < self.distToDest) {
        self.distToDest = dist;
    }
    else {
        [self setLocation:self.destination];
    }
}

-(void)setLocation:(CGPoint)pt {
    [self setFrame:CGRectMake(pt.x, pt.y, self.frame.size.width, self.frame.size.height)];
    self.ax = 0.0f;
    self.ay = 0.0f;
}

-(void)moveToLocation:(CGPoint)pt speed:(CGFloat)pps {
    self.destination = pt;
    self.distToDest = abs(self.frame.origin.x - self.destination.x) + abs(self.frame.origin.y - self.destination.y);
    
    CGFloat distx = pt.x - self.frame.origin.x;
    CGFloat disty = pt.y - self.frame.origin.y;
    CGFloat distz = sqrtf(pow(distx,2) + pow(disty, 2));
    self.ax = distx/distz * pps;
    self.ay = disty/distz * pps;
    
}

//-(void)setLocation:(FTTile *)tile {
////	self.x = tile.x;
////	self.y = tile.y;
//}

-(void)setLocationWithParams:(NSDictionary *)params {
//	[self setLocation:[params objectForKey:@"tile"]];
}

-(void)moveTo:(FTTile *)tile {
	
//	[UIView beginAnimations:nil context:nil];
//	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
//	[UIView setAnimationDuration:0.1f];
//	// Do yah animation
//	[self.view setFrame:tile.view.frame];
//	
//	[UIView commitAnimations];
//	
////	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:tile, @"tile", nil];
////	[NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(setLocationWithParams:) userInfo:params repeats:NO];
//	[self performSelector:@selector(setLocation:) withObject:tile afterDelay:0.3f];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EntityTouched" object:nil userInfo:[NSDictionary dictionaryWithObject:self forKey:@"entity"]];
}


@end
