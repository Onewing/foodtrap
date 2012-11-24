//
//  DDKey.m
//  Food Trap
//
//  Created by Steven Silvey on 4/15/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "FTKey.h"

@implementation FTKey

@synthesize keyCode = _keyCode;
@synthesize used = _used;


-(NSString *)description {
	return [NSString stringWithFormat:@"%d", self.keyCode];
}


@end
