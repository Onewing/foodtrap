//
//  DDArea.m
//  Food Trap
//
//  Created by Steven Silvey on 4/14/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "FTArea.h"

@implementation FTArea

@synthesize area = _area;
@synthesize deniedGateways = _deniedGateways;
@synthesize arrKeys = _arrKeys;
@synthesize gateways = _gateways;
@synthesize arrAreas = _arrAreas;
@synthesize canGetLockedOutOf = _canGetLockedOutOf;

-(NSString *)description {
	NSMutableString *deniedCodes = [[NSMutableString alloc] initWithFormat:@""];
	for (NSNumber *keyCode in self.deniedGateways) {
		[deniedCodes appendFormat:@"%d ", [keyCode intValue]];
	}
	return [NSString stringWithFormat:@"DDArea: %d with denied: %@", self.area, deniedCodes];
}


-(id)init {
	self = [super init];
	if (self) {
		self.area = -1;
		self.deniedGateways = [[NSMutableArray alloc] init];
		self.arrKeys = [[NSMutableArray alloc] init];
		self.gateways = [[NSMutableArray alloc] init];
		self.arrAreas = [[NSMutableArray alloc] init];
		self.canGetLockedOutOf = NO;
	}
	
	return self;
}

@end
