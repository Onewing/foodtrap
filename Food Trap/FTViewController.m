//
//  FTViewController.m
//  Food Trap
//
//  Created by Steven Silvey on 11/24/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "FTViewController.h"
#import "FTTile.h"
#import "FTArea.h"
#import "FTKey.h"


@interface FTViewController ()

@end

@implementation FTViewController

@synthesize level = _level;
@synthesize openTiles = _openTiles;
@synthesize test = _test;
@synthesize player = _player;
@synthesize allAreas = _allAreas;
@synthesize gateways = _gateways;
@synthesize collectedKeys = _collectedKeys;
@synthesize arrEnemies = _arrEnemies;
@synthesize arrOpenTiles = _arrOpenTiles;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 
#pragma mark Private Methods

-(void)drawTiles {
	for(FTTile *tile in self.level) {
		[tile.view drawRect:tile.view.frame];
		
	}
}

-(void)drawEnemies {
//	for(FTEnemy *enemy in self.arrEnemies) {
//		[enemy.view drawRect:enemy.view.frame];
//	}
}

-(void)render {
	[self drawTiles];
	[self drawEnemies];
}

-(FTTile *)getTileAtX:(NSInteger)x Y:(NSInteger)y {
	if (x < 0 || y < 0 || x >= MAXX || y >= MAXY ) {
		return nil;
	}
	if (y*MAXX+x >= [self.level count]) {
		return nil;
	}
	return [self.level objectAtIndex:y*MAXX+x];
}

-(NSArray *)chooseOpenTiles:(FTTile *)around {
	int choose = arc4random() % 4 + 1;
	BOOL left = NO, right = NO, up = NO, down = NO;
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
	///Choose open guys
	while (choose > 0) {
		if (!left && arc4random() % 100 > 50) {
			left = YES;
			FTTile *tile = [self getTileAtX:around.x-1 Y:around.y];
			if (tile && !tile.isComplete) {
				tile.isOpen = YES;
				[returnArray addObject:tile];
			}
			choose--;
			
		}
		if (!right && arc4random() % 100 > 50) {
			right = YES;
			FTTile *tile = [self getTileAtX:around.x+1 Y:around.y];
			if (tile && !tile.isComplete) {
				tile.isOpen = YES;
				[returnArray addObject:tile];
			}
			
			choose--;
		}
		if (!down && arc4random() % 100 > 50) {
			down = YES;
			FTTile *tile = [self getTileAtX:around.x Y:around.y+1];
			if (tile && !tile.isComplete) {
				tile.isOpen = YES;
				[returnArray addObject:tile];
			}
			
			choose--;
		}
		if (!up && arc4random() % 100 > 50) {
			up = YES;
			FTTile *tile = [self getTileAtX:around.x Y:around.y-1];
			if (tile && !tile.isComplete) {
				tile.isOpen = YES;
				[returnArray addObject:tile];
			}
			
			choose--;
		}
	}
	
	around.isComplete = YES;
	return returnArray;
}

-(NSUInteger) openAdjacentTilesAround:(FTTile *)tile {
	NSUInteger openTiles = 0;
	FTTile *up = [self getTileAtX:tile.x Y:tile.y-1];
	if (up && [up checkIfOpen]) {
		openTiles++;
	}
	FTTile *down = [self getTileAtX:tile.x Y:tile.y+1];
	if (down && [down checkIfOpen]) {
		openTiles++;
	}
	FTTile *left = [self getTileAtX:tile.x-1 Y:tile.y];
	if (left && [left checkIfOpen]) {
		openTiles++;
	}
	FTTile *right = [self getTileAtX:tile.x+1 Y:tile.y];
	if (right && [right checkIfOpen]) {
		openTiles++;
	}
	return openTiles;
}

-(NSArray *) potentialSpotsAround:(FTTile *)tile mainPath:(NSInteger)i{
	NSMutableArray *potentialSpots = [[NSMutableArray alloc] init];
	FTTile *up = [self getTileAtX:tile.x Y:tile.y-1];
	if (up && [self openAdjacentTilesAround:up] <= i  && up.state != DEADEND) {
		[potentialSpots addObject:up];
	}
	
	FTTile *down = [self getTileAtX:tile.x Y:tile.y+1];
	if (down && [self openAdjacentTilesAround:down] <= i && down.state != DEADEND) {
		[potentialSpots addObject:down];
	}
	
	FTTile *left = [self getTileAtX:tile.x-1 Y:tile.y];
	if (left && [self openAdjacentTilesAround:left] <= i && left.state != DEADEND) {
		[potentialSpots addObject:left];
	}
	
	FTTile *right = [self getTileAtX:tile.x+1 Y:tile.y];
	if (right && [self openAdjacentTilesAround:right] <= i && right.state != DEADEND) {
		[potentialSpots addObject:right];
	}
	
//	for (DDTile *cleanse in potentialSpots) {
//		if (cleanse.state == CLOSED) {
//			[potentialSpots removeObject:cleanse];
//		}
//	}
	
	return potentialSpots;
}

-(NSArray *) potentialSpotsAroundDeadend:(FTTile *)tile mainPath:(NSInteger)i{
	NSMutableArray *potentialSpots = [[NSMutableArray alloc] init];
	FTTile *up = [self getTileAtX:tile.x Y:tile.y-1];
	if (up && [self openAdjacentTilesAround:up] <= i  && up.state != DEADEND) {
		[potentialSpots addObject:up];
	}
	
	FTTile *down = [self getTileAtX:tile.x Y:tile.y+1];
	if (down && [self openAdjacentTilesAround:down] <= i && down.state != DEADEND) {
		[potentialSpots addObject:down];
	}
	
	FTTile *left = [self getTileAtX:tile.x-1 Y:tile.y];
	if (left && [self openAdjacentTilesAround:left] <= i && left.state != DEADEND) {
		[potentialSpots addObject:left];
	}
	
	FTTile *right = [self getTileAtX:tile.x+1 Y:tile.y];
	if (right && [self openAdjacentTilesAround:right] <= i && right.state != DEADEND) {
		[potentialSpots addObject:right];
	}
	
	//	for (DDTile *cleanse in potentialSpots) {
	//		if (cleanse.state == CLOSED) {
	//			[potentialSpots removeObject:cleanse];
	//		}
	//	}
	
	return potentialSpots;
}


-(NSArray *) adjacentSpotsAround:(FTTile *)tile {
	NSMutableArray *adjacentSpots = [[NSMutableArray alloc] init];
	FTTile *up = [self getTileAtX:tile.x Y:tile.y-1];
	if (up){
		[adjacentSpots addObject:up];
	}
	
	FTTile *down = [self getTileAtX:tile.x Y:tile.y+1];
	if (down){
		[adjacentSpots addObject:down];
	}
	
	FTTile *left = [self getTileAtX:tile.x-1 Y:tile.y];
	if (left){
		[adjacentSpots addObject:left];
	}
	
	FTTile *right = [self getTileAtX:tile.x+1 Y:tile.y];
	if (right){
		[adjacentSpots addObject:right];
	}
	return adjacentSpots;
}

-(BOOL) isHallway:(FTTile *)tile {
	FTTile *up = [self getTileAtX:tile.x Y:tile.y-1];
	FTTile *down = [self getTileAtX:tile.x Y:tile.y+1];
	FTTile *left = [self getTileAtX:tile.x-1 Y:tile.y];
	FTTile *right = [self getTileAtX:tile.x+1 Y:tile.y];
	
	if (up && down && left && right) {
		if (up.state == CLOSED && down.state == CLOSED && left.state == OPEN && right.state == OPEN) {
			return  YES;
		}
		
		if (up.state == OPEN && down.state == OPEN && left.state == CLOSED && right.state == CLOSED) {
			return  YES;
		}
	}
	return NO;
}

-(NSArray *)potentialPendingSpotsAround:(FTTile *)tile {
	NSMutableArray *potentialPendingSpots = [[NSMutableArray alloc] init];
	NSArray *adjtiles = [self adjacentSpotsAround:tile];
	for(FTTile *adj in adjtiles) {
		if (adj.state == PENDING) {
			[potentialPendingSpots addObject:adj];
		}
	}
	return potentialPendingSpots;
}

-(void)blah {
	self.test = NO;
}

-(void)makePath:(FTTile *)startTile endState:(PATH_STATE)endState steps:(NSInteger)step_count{
	[startTile setState:OPEN];
	/// Amount of steps to the end
//	int step_count = 5;
	int steps = 0;
	
	FTTile *current = startTile;
	NSMutableArray *thePath = [[NSMutableArray alloc] init];
	[thePath addObject:startTile];
	while (steps < step_count) {
		NSLog(@"%@", thePath);
//		if ([current.lblSteps.text isEqualToString:@"0"]) {
//			[current.lblSteps setText:[NSString stringWithFormat:@"%d", steps]];
//		}
//		else {
//			[current.lblSteps setText:[NSString stringWithFormat:@"%d %@", steps, current.lblSteps.text]];
//		}
		if (steps > [startTile.lblSteps.text intValue]) {
			[startTile.lblSteps setText:[NSString stringWithFormat:@"%d", steps]];
		}
		
		
		
		NSArray *potentialSpots = [self potentialSpotsAround:current mainPath:1];	
		
		
		if ([potentialSpots count] > 0) {
			int pickedSpot = (arc4random() % [potentialSpots count]);
			int i = 0;
			for (FTTile *tile in potentialSpots) {
				if(i == pickedSpot) {
					if (steps == step_count-1) {
						[tile setState:endState];	
					}
					else {
						[tile setState:OPEN];	
					}
					
					current = tile;
					[thePath addObject:tile];
					
				}
				else {
					if (tile.state == CLOSED || tile.state == NO_STATE) {
						[tile setState:PENDING];
					}
					
				}
				i++;
			}
			steps++;
		}
		else {
			
			NSArray *potentialSpots = nil;
			while ((potentialSpots == nil || [potentialSpots count] == 0) && [thePath count] > 0) {
				
//				[current setState:DEADEND];
				[thePath removeLastObject];
				if ([thePath count] > 0) {
					current = [thePath lastObject];
				}
				
				
				steps--;
				potentialSpots = [self potentialPendingSpotsAround:current];
			}
			if ([thePath count] == 0) {
				steps = step_count;
			}
			
		}
		NSArray *adjacentSpots = [self adjacentSpotsAround:current];
		for (FTTile *tile in adjacentSpots) {
			if (tile.state == NO_STATE) {
				[tile setState:CLOSED];
			}
		}
		
		
		
	}
}

-(BOOL)isNotDefinedArea:(FTTile *)tile {
	if ([tile checkIfOpen] && tile.area == -1 && !tile.gateway) {
		return YES;
	}
	return NO;
}

-(void)defineArea:(FTTile *)tile asAreaNumber:(NSInteger)area{
	tile.area = area;
	for(FTTile *adj in [self adjacentSpotsAround:tile]) {
		if ([self isNotDefinedArea:adj]) {
			[self defineArea:adj asAreaNumber:area];
		}
		if (adj.gateway) {
			[adj updateGateway:area];
		}
	}
}

-(BOOL) placeKey:(NSInteger)gatewayCode inArea:(NSArray *)areas {
	/// Pick an acceptable area
	
	int area = arc4random() % areas.count;
	NSLog(@"pick area");
	FTArea *areaObject = [areas objectAtIndex:area];
	BOOL acceptable = YES, complete = NO;
	int tryToPlaceKey = 0;
	while(!complete && tryToPlaceKey < 100) {
		acceptable = YES;
		for(NSNumber *denied in areaObject.deniedGateways) {
			if ([denied intValue] == gatewayCode) {
				acceptable = NO;
				area = arc4random() % areas.count;
				NSLog(@"pick area again");
				areaObject = [areas objectAtIndex:area];
				break;
			}
		}
		if (acceptable) {
			complete = YES;
		}
		tryToPlaceKey++;
	}
	
	if (tryToPlaceKey >= 100) {
		return NO;
	}
	
	
	
	NSMutableArray *reachableTiles = [[NSMutableArray alloc] init];
	
	for(FTTile *tile in self.level) {
		if (tile.area == areaObject.area && tile.keyCode == -1) {
			[reachableTiles addObject:tile];
		}
	}
	if ([reachableTiles count] == 0) {
		return NO;
	}
	
	/// choose a tile to place the key
	int tileWithKey = arc4random() % reachableTiles.count;
	NSLog(@"placekey");
	FTTile *placeHere = [reachableTiles objectAtIndex:tileWithKey];
	while (placeHere.keyCode != -1) {
		NSLog(@"crap, the tile we chose already has a key on it!");
		tileWithKey = arc4random() % reachableTiles.count;
		placeHere = [reachableTiles objectAtIndex:tileWithKey];
	}
	
	/// Place on the tile
	placeHere.keyCode = gatewayCode;
	if (placeHere.state == START) {
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:nil
							  message:@"Key on start location!"
							  delegate:nil
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil, nil];
		[alert show];
		
	}
	/// Inform the area it has this key
	for(FTArea *area in self.allAreas) {
		if (area.area == placeHere.area) {
			FTKey *key = [[FTKey alloc] init];
			key.keyCode = gatewayCode;
			[area.arrKeys addObject:key];
		}
	}
	
	return YES;
}

-(void) doNotPlaceKey:(NSInteger)gatewayCode inArea:(NSArray *)areas {
	for(FTArea *area in areas) {
		BOOL addDenied = YES;
		for (NSNumber *deniedCode in area.deniedGateways) {
			if ([deniedCode intValue] == gatewayCode) {
				addDenied = NO;
				break;
			}
		}
		if (addDenied) {
			[area.deniedGateways addObject:[NSNumber numberWithInt:gatewayCode]];
		}
		
	}
}

-(int) discoverNewArea:(FTTile *)gateway using:(NSArray *)areas {
	BOOL left = YES;
	for(FTArea *area in areas) {
		if (gateway.gatewayArea1 == area.area) {
			left = NO;
		}
	}
	BOOL right = YES;
	for (FTArea *area in areas) {
		if (gateway.gatewayArea2 == area.area) {
			right = NO;
		}
	}
	
	if (left) {
		return gateway.gatewayArea1;
	}
	if (right) {
		return gateway.gatewayArea2;
	}
	
	return -1;
}

-(FTArea *)getArea:(NSInteger)areaCode {
	FTArea *selected = nil;
	for(FTArea *area in self.allAreas) {
		if (area.area == areaCode) {
			selected = area;
		}
	}
	return selected;
}

-(void)analyticalLog:(NSString *)msg {
//	NSLog(@"%@", msg);
}

-(void)analyzeAreas:(NSArray *)alwaysReachable {
	BOOL usedAKey = NO;
	[self analyticalLog:[NSString stringWithFormat:@"Reachable area: %@", alwaysReachable]];
	//temp
	NSMutableArray *collectedKeys = [[NSMutableArray alloc] init];
	for(FTArea *reachable in alwaysReachable) {
		for(FTKey *key in reachable.arrKeys) {
			[self analyticalLog:[NSString stringWithFormat:@"I can has this key:  %@ and it is %@", key, key.used == YES ? @"used" : @"not used"]];
			[collectedKeys addObject:key];
		}
	}
	for(FTArea *reachable in alwaysReachable) {
		[self analyticalLog:[NSString stringWithFormat:@"searching area: %@", reachable]];
		[self analyticalLog:[NSString stringWithFormat:@"area's gateways: %@", reachable.gateways]];
		for(FTKey *key in collectedKeys) {
			if (!key.used) {
				
				// How many choices do I have with this key?
				NSMutableArray *doorsToChooseFrom = [[NSMutableArray alloc] init];
				
				for(FTTile *door in reachable.gateways) {
					if (!door.used && door.gatewayCode == key.keyCode) {
						[doorsToChooseFrom addObject:door];
					}
				}
				key.used = YES;
				[self analyticalLog:[NSString stringWithFormat:@"Doors to choose from: %@", doorsToChooseFrom]];
				for(FTTile *door in doorsToChooseFrom) {
					/// What area did we open
					door.used = YES;
					int newArea = [self discoverNewArea:door using:alwaysReachable];
					if(newArea != -1) {
						NSMutableArray *expandedArea = [NSMutableArray arrayWithArray:alwaysReachable];
						FTArea *newfoundArea = [self getArea:newArea];
						[expandedArea addObject:newfoundArea];
						usedAKey = YES;
						[self analyticalLog:[NSString stringWithFormat:@"Using this key: %@", key]];
						[self analyzeAreas:expandedArea];
					}
					door.used = NO;
				}
				key.used = NO;
				[self analyticalLog:[NSString stringWithFormat:@"Not using this key: %@", key]];
				
			}
		}
	}
	if(!usedAKey) {
		/// We've run out of keys to use in this analyzation.  Check to see if there were any areas we
		/// couldn't get to
		[self analyticalLog:@"Possible inaccessible area"];
		for(FTArea *possibleArea in self.allAreas) {
			if(!possibleArea.canGetLockedOutOf) {
				possibleArea.canGetLockedOutOf = YES;
				
				for(FTArea *reachableArea in alwaysReachable) {
					
					if (possibleArea.area == reachableArea.area) {
						possibleArea.canGetLockedOutOf = NO;
						break;
					}
					
				}
				
				if (possibleArea.canGetLockedOutOf) {
					[self analyticalLog:[NSString stringWithFormat:@"can get locked out of area %d", possibleArea.area]];
				}
			}
		}
	}
	
}

/// This should only happen at one time.
-(void) createLevel {
	NSMutableArray *levelTiles = [[NSMutableArray alloc] init];
	int tilePositionX = 0;
	int tilePositionY = 0;
	
	/// Allocate tiles
	for (int y = 0; y<MAXY; y++) {
		tilePositionX = 0;
		
		for(int x = 0; x < MAXX; x++) {
			FTTile *tile = [[FTTile alloc] initWithNibName:@"vTile" bundle:nil];
			CGRect frame = tile.view.frame;
			frame.origin = CGPointMake(tilePositionX, tilePositionY);
			frame.size = CGSizeMake(TILEW, TILEH);
			[tile.view setFrame:frame];
			tile.x = x;
			tile.y = y;
			tile.delegate = self;
			
#warning "Doesn't make sense to add subviews here!"
			[self.view addSubview:tile.view];
			[levelTiles addObject:tile];
			
			tilePositionX += TILEW;
		}
		tilePositionY += TILEH;
	}
	self.level = levelTiles;
	
	/// Step 1:  Create the start-to-end path.
	/// NOTE:  A space in a path can be created if the adjacent tiles only amount to one open tile
	/// NOTE:  All tiles around an open path are put in a pending state
	
//	/// Pick a location for the start
//	int startX = arc4random() % MAXX;
//	int startY = arc4random() % MAXY;
//	FTTile *startTile = [self getTileAtX:startX Y:startY];
//	FTPlayer *player = [[FTPlayer alloc] initWithNibName:@"vPlayer" bundle:nil];
//	CGRect frame = player.view.frame;
//	frame.origin = CGPointMake(startX*TILEW, startY*TILEH);
//	frame.size = CGSizeMake(TILEW, TILEH);
//	[player.view setFrame:frame];
//	player.x = startX;
//	player.y = startY;
//	self.player = player;
//	[self.view addSubview:player.view];
//	
//	[self makePath:startTile endState:END steps:17];
//	[startTile setDiscovered:YES];
//	[startTile setState:START];
//	for(FTTile *adj in [self adjacentSpotsAround:startTile]) {
//		if (adj.state != CLOSED) {
//			[adj setDiscovered:YES];
//			[adj setVisibility:1.0f];
//			for(FTTile *adjadj in [self adjacentSpotsAround:adj]) {
//				if (adjadj.visibility == 0.15f) {
//					[adjadj setVisibility:0.5f];
//					[adjadj setDiscovered:YES];
//				}
//			}	
//		}
//		
//	}
	
	
	/// Step 2: Create deadends
	BOOL complete = NO;
	while (!complete) {
		complete = YES;
		for(FTTile *tile in self.level) {
			if (tile.state == PENDING) {
				complete = NO;
				if (arc4random() % 100 > 50) {
					tile.state = OPEN;
					[self makePath:tile endState:OPEN steps:(arc4random() % 10 + 3)];
				}
				else {
					tile.state = CLOSED;
				}
			}
		}
	}
	
	/// Step 3: Create Loops
	for(FTTile *tile in self.level) {
		if (tile.state == CLOSED) {
			NSArray *adjs = [self adjacentSpotsAround:tile];
			BOOL potential = YES;
			for (FTTile *adj in adjs) {
				if (adj.state == NO_STATE || adj.state == END) {
					potential = NO;
				}
			}
			if (potential && arc4random() % 100 > 90) {
				[tile setState:OPEN];
			}
		}
	}
	
	
	/// Analyze
	
	/// Step 4: Find pinch-spots (Gateway from one area to another)
	/// Pinch spots are an open spot with a wall on the top/bottom and opening on the left/right or
	/// vice versa
	NSMutableArray *arrPinchSpots = [[NSMutableArray alloc] init];
	for(FTTile *tile in self.level) {
		if (tile.state == OPEN) {
			if ([self isHallway:tile]) {
				NSArray *arrAdj = [self adjacentSpotsAround:tile];
				for(FTTile *adj in arrAdj) {
					if (!tile.pinch && !adj.pinch && adj.state == OPEN && [self openAdjacentTilesAround:adj] >= 3) {
						tile.pinch = YES;
						[arrPinchSpots addObject:tile];
					}
				}
			}
			
		}
	}
	
	/// Step 5:  Determine Gateways based off pinch-spots
	int gatewayCount = 8;
	int total = gatewayCount;
	NSLog(@"Total amount of gateways:  %d", total);
	if (gatewayCount >= arrPinchSpots.count) {
		/// Ensure we aren't expecting more gateways than pinch spots (infinite loop)
		gatewayCount = arrPinchSpots.count - 1;
	}
	self.gateways = [[NSMutableArray alloc] init];
	while (gatewayCount > 0) {
		NSLog(@"Attempting to set a gateway.");
		FTTile *potentialGateway = [arrPinchSpots objectAtIndex:(arc4random() % (arrPinchSpots.count))];
		if (potentialGateway.gateway == NO) {
			potentialGateway.gateway = YES;
			potentialGateway.gatewayCode = arc4random() % 3;
			gatewayCount--;
			[self.gateways addObject:potentialGateway];
		}
	}
	
	/// Step 6:  Determine all the areas
	int i = 0;
	self.allAreas = [[NSMutableArray alloc] init];
	self.arrOpenTiles = [NSMutableArray array];
	for(FTTile *tile in self.level) {
		if ([self isNotDefinedArea:tile]) {
			FTArea *anArea = [[FTArea alloc] init];
			anArea.area = i;
			[self.allAreas addObject:anArea];
			[self defineArea:tile asAreaNumber:i++];
			
		}
		
		/// All the open tiles have been defined at this point, nothing else is going to be "closed", so let's use
		/// this loop to add to the array of "open" tiles
		if (tile.state == OPEN) {
			[self.arrOpenTiles addObject:tile];
		}
	}
	
	/// Step 7:  Figure out where the keys are based on this pseudo-algorithm
	//		Write down reachable area
	//		Write down reachable gateways
	//		If only 1 reachable gateway, key must be in reachable area
	//		Otherwise, pick two gateways and make a choice
	//		Choice:  Either gateway A's key is in reachable area or not
	//		Pick the area and place the key that is reachable
	//		All reachable areas are marked as not able to hold the non-reachable key
	//		Pop the reachable gateway from the list
	//		Add the newly reached area
	//		Determine if subsequent gateways (if more than 2) one by one via the choice
	//		Add the newly reachable gateways
	//		Repeat
	
//	/// Write down reachable area
//	NSMutableArray *reachableArea = [[NSMutableArray alloc] init];
//	FTArea *startArea = [self getArea:startTile.area];
//	[reachableArea addObject:startArea];
//	
//	/// Write down reachable gateways
//	NSMutableArray *reachableGateways = [[NSMutableArray alloc] init];
//	for(FTArea *reachable in reachableArea) {
//		for(FTTile *gateway in self.gateways) {
//			if (gateway.gatewayArea1 == reachable.area || gateway.gatewayArea2 == reachable.area) {
//				[reachableGateways addObject:gateway];
//				[reachable.gateways addObject:gateway];
//			}
//		}
//	}
	
//	while(reachableGateways.count > 0) {
//		FTTile *unlockedGateway = nil;
//		FTTile *deniedGateway = nil;
//		/// If only 1 reachable gateway, key must be in reachable area
//		if (reachableGateways.count == 1) {
//			NSLog(@"case 1");
//			FTTile *reachableGateway = [reachableGateways objectAtIndex:0];
//			if([self placeKey:reachableGateway.gatewayCode inArea:reachableArea]) {
//				
//				// Pop the reachable gateway from the list
//				// For now, brute-forcing it and telling the later steps not to add this back
//				reachableGateway.matchingKey = YES;		/// Basically means I unlocked this gateway
//				[reachableGateways removeObject:reachableGateway];
//				unlockedGateway = reachableGateway;
//				
//				
//			}
//			// Determine if subsequent gateways (if more than 2) one by one via the choice
//			//????
//		}
//		else if(reachableGateways.count > 1) {
//			/// Otherwise, pick two gateways and make a choice
//			NSLog(@"case 2");
//			FTTile *reachableGateway1 = [reachableGateways objectAtIndex:0];
//			FTTile *reachableGateway2 = [reachableGateways objectAtIndex:1];
//			FTTile *reachableGateway;
//			FTTile *notReachableGateway;
//			
//			///	Choice:  Either gateway A's key is in reachable area or not
//			int choice = arc4random() % 100;
//			if (choice < 50) {
//				reachableGateway = reachableGateway1;
//				notReachableGateway = reachableGateway2;
//			}
//			else {
//				reachableGateway = reachableGateway2;
//				notReachableGateway = reachableGateway1;
//				
//			}
//			
//			// Pick the area and place the key that is reachable
//			if([self placeKey:reachableGateway.gatewayCode inArea:reachableArea]) {
//				if (unlockedGateway.gatewayCode != notReachableGateway.gatewayCode) {
//					deniedGateway = notReachableGateway;
//				}
//
//				
//				
//				
//				// Pop the reachable gateway from the list
//				// For now, brute-forcing it and telling the later steps not to add this back
//				reachableGateway.matchingKey = YES;		/// Basically means I unlocked this gateway
//				[reachableGateways removeObject:reachableGateway];
//				unlockedGateway = reachableGateway;
//				
//				
//				
//				// Determine if subsequent gateways (if more than 2) one by one via the choice
//				//????
//			}
//			
//			
//		}
//		else {
//			NSLog(@"Error!");
//			
//		}
//		
//		// Add the newly reached area
//		int discoveredAreaCode = [self discoverNewArea:unlockedGateway using:reachableArea];
//		if (discoveredAreaCode != -1) {
//			// All reachable areas are marked as not able to hold the non-reachable key
//			if (deniedGateway) {
//				[self doNotPlaceKey:deniedGateway.gatewayCode inArea:reachableArea];
//			}
//			
//			/// Add new area (where an denied key could be)
//			FTArea *discoveredArea = [self getArea:discoveredAreaCode];
//			[reachableArea addObject:discoveredArea];
//			
//			for(FTTile *gateway in self.gateways) {
//				if (gateway.gatewayArea1 == discoveredArea.area || gateway.gatewayArea2 == discoveredArea.area) {
//					if (![reachableGateways containsObject:gateway] && !gateway.matchingKey) {
//						[reachableGateways addObject:gateway];	
//						[discoveredArea.gateways addObject:gateway];
//					}
//				}
//			}
//			
//			
//			
//		}
//		else {
//			NSLog(@"shift through");
//			if ([reachableGateways count] > 0) {
//				FTTile *sendToBack = [reachableGateways objectAtIndex:0];
//				[reachableGateways removeObjectAtIndex:0];
//				[reachableGateways addObject:sendToBack];	
//			}
//			
//		}
//	}
	
//	/// Analyze:  Deterimine if an area could potentially be unavailable if making a ceratin set of choices
//	NSLog(@"\n\n\n\n\n\n\n\n\n#############################################\n\n");
//	[self analyzeAreas:[NSArray arrayWithObject:startArea]];
//	for(FTArea *area in self.allAreas) {
//		if (area.canGetLockedOutOf) {
//			for(FTTile *tile in self.level) {
//				if (tile.area == area.area) {
//					tile.harder = YES;
//				}
//			}
//		}
//		
//	}
	
	
//	/// Step 8:  Put down some enemies
//	int enemyCount = 3;
//	self.arrEnemies = [NSMutableArray array];
//	while(enemyCount > 0) {
//		FTTile *potentialEnemyTile = [self.arrOpenTiles objectAtIndex:(arc4random() % self.arrOpenTiles.count)];
//		if (!potentialEnemyTile.gateway) {
//			FTEnemy *newEnemy = [[FTEnemy alloc] init];
//			[newEnemy moveTo:potentialEnemyTile];
//			[self.view addSubview:newEnemy.view];
//			[self.arrEnemies addObject:newEnemy];
//			enemyCount--;
//		}
//		
//		
//	}
	
	
	
	
	[self render];
	
	
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 
#pragma mark DDTile Tapped Delegate
-(void)tileTapped:(FTTile *)tile {
//	FTTile *playersTile = [self getTileAtX:self.player.x Y:self.player.y];
//	NSArray *arrAdj = [self adjacentSpotsAround:playersTile];
//	if ([arrAdj containsObject:tile]) {
//		
//		/// Can't walk through doors!
//		if (tile.gatewayCode != -1) {
//			BOOL blocked = YES;
//			int ndx = 0;
//			for(NSNumber *key in self.collectedKeys) {
//				if ([key intValue] == tile.gatewayCode) {
//					tile.gatewayCode = -1;
//					[self.collectedKeys removeObjectAtIndex:ndx];
//					blocked = NO;
//					break;
//				}
//				ndx++;
//			}
//			if (blocked) {
//				return;
//			}
//			
//		}
//		
//		if (tile.state != CLOSED) {
//			for(FTTile *t in self.level) {
//				[t setVisibility:0.15f];
//			}
//			[self.player moveTo:tile];
//			[tile setVisibility:1.0f];
//			for(FTTile *adj in [self adjacentSpotsAround:tile]) {
//				if (adj.state != CLOSED) {
//					[adj setDiscovered:YES];
//					[adj setVisibility:1.0f];
//					for(FTTile *adjadj in [self adjacentSpotsAround:adj]) {
//						if (adjadj.visibility == 0.15f) {
//							[adjadj setVisibility:0.5f];
//							[adjadj setDiscovered:YES];
//						}
//					}	
//				}
//				
//			}
//
//			/// Collect a key!
//			if (tile.keyCode != -1) {
//				[self.collectedKeys addObject:[NSNumber numberWithInt:tile.keyCode]];
//				tile.keyCode = -1;
//				
//			}
//			[self render];
//		}
//		
//	}

	
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 
#pragma mark View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.collectedKeys = [[NSMutableArray alloc] init];
	[self createLevel];
	[self render];
	
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
