//
//  FTTile.m
//  Food Trap
//
//  Created by Steven Silvey on 11/24/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import "FTTile.h"

@implementation DDTileView

@synthesize tile = _tile;


-(void)drawRect:(CGRect)rect {
	switch (self.tile.state) {
		case OPEN:
			
			[self.tile setColor:[UIColor whiteColor]];
			if (self.tile.harder) {
				[self.tile setColor:[UIColor colorWithRed:0.8f green:0.8f blue:0.5f alpha:1.0f]];
			}
			if (self.tile.gateway) {
				if (self.tile.gatewayCode == 0) {
					[self.tile setColor:[UIColor orangeColor]];
				}
				if (self.tile.gatewayCode == 1) {
					[self.tile setColor:[UIColor greenColor]];
				}
				if (self.tile.gatewayCode == 2) {
					[self.tile setColor:[UIColor cyanColor]];
				}
			}
			if (self.tile.keyCode != -1) {
				if (self.tile.keyCode == 0) {
					[self.tile setColor:[UIColor colorWithRed:0.5f green:0.25f blue:0.0f alpha:1.0f]];
				}
				if (self.tile.keyCode == 1) {
					[self.tile setColor:[UIColor colorWithRed:0.0f green:0.5f blue:0.0f alpha:1.0f]];
				}
				if (self.tile.keyCode == 2) {
					[self.tile setColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.5f alpha:1.0f]];
				}
			}
			break;
		case PENDING:
			[self.tile setColor:[UIColor redColor]];
			break;
		case CLOSED:
			[self.tile setColor:[UIColor blackColor]];
			break;
		case START:
			[self.tile setColor:[UIColor yellowColor]];
			break;
		case END:
			[self.tile setColor:[UIColor blueColor]];
			break;
		case DEADEND:
			[self.tile setColor:[UIColor greenColor]];
			break;
		case TEST:
//			[self.tile setColor:[UIColor whiteColor]];
			break;
		case NO_STATE:
//			if (arc4random() % 100 > 50) {
//				[self.tile setColor:[UIColor yellowColor]];
//			}
//			else {
//				[self.tile setColor:[UIColor redColor]];
//			}
			[self.tile setColor:[UIColor purpleColor]];
			
			break;
		default:
			break;
	}
	if (DEVTEST_FORCE_LIGHTS_ON) {
		[self.tile.vDarkness setAlpha:0.0f];
		[self.tile setDiscovered:YES];
		
	}
	else {
		if (self.tile.state == CLOSED) {
			self.tile.visibility /= 2.0f;
		}
		[self.tile.vDarkness setAlpha:(1.0f-self.tile.visibility)];	
		if (self.tile.state == NO_STATE) {
			[self.tile.vDarkness setAlpha:0.5f];	
			[self.tile setDiscovered:YES];
		}
		
	}
	
	if (self.tile.state != CLOSED && self.tile.state != NO_STATE) {
		[self.tile.lblSteps setText:[NSString stringWithFormat:@"%d",self.tile.area]];
	}
	else {
		[self.tile.lblSteps setHidden:YES];
	}
	
	if (self.tile.gateway) {
		[self.tile.lblSteps setText:[NSString stringWithFormat:@"%d %d", self.tile.gatewayArea1, self.tile.gatewayArea2]];
	}
	if (self.tile.keyCode != -1) {
		[self.tile.lblSteps setText:[NSString stringWithFormat:@"%d",self.tile.keyCode]];
	}
	CGRect frame = self.tile.lblSteps.frame;
	frame.size = self.tile.view.frame.size;
	[self.tile.lblSteps setFrame:frame];
	
	[super drawRect:rect];
}

@end

@implementation FTTile

@synthesize isOpen = _isOpen;
@synthesize isComplete = _isComplete;
@synthesize x = _x, y = _y;
@synthesize state = _state;
@synthesize lblSteps = _lblSteps;
@synthesize delegate = _delegate;
@synthesize visibility = _visibility;
@synthesize discovered = _discovered;
@synthesize vDarkness = _vDarkness;
@synthesize pinch = _pinch;
@synthesize area = _area;
@synthesize gatewayArea1 = _gatewayArea1;
@synthesize gatewayArea2 = _gatewayArea2;
@synthesize gateway = _gateway;
@synthesize gatewayCode = _gatewayCode;
@synthesize keyCode = _keyCode;
@synthesize matchingKey = _matchingKey;
@synthesize harder = _harder;
@synthesize used = _used;



CGFloat rand255() {
	return (rand() % 255) / 255.0f;
}

-(void)setIsOpen:(BOOL)isOpen {
	_isOpen = isOpen;
//	[self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setColor:(UIColor *)col {
	if (!self.discovered) {
		[self.view setBackgroundColor:[UIColor blackColor]];
	}
	else {
		[self.view setBackgroundColor:col];
	}
}

-(void)setState:(PATH_STATE)state {
	_state = state;
	
}

-(NSString *)description {
	if (self.gateway) {
		return [NSString stringWithFormat:@"tile x: %d   y: %d  g1: %d  g2:%d  key:%d", self.x, self.y, self.gatewayArea1, self.gatewayArea2, self.gatewayCode];
	}
	else {
		return [NSString stringWithFormat:@"tile x: %d   y: %d", self.x, self.y];
	}
	
}

-(BOOL)checkIfOpen {
	if (self.state != CLOSED && self.state != NO_STATE) {
		return YES;
	}
	return NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"test");
	[self.delegate tileTapped:self];
}

-(void)updateGateway:(NSInteger)newArea {
	if (self.gatewayArea1 == -1) {
		self.gatewayArea1 = newArea;
	}
	else {
		self.gatewayArea2 = newArea;
	}
}


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	[self setState:NO_STATE];
	[self setVisibility:0.0f];
	[self setDiscovered:NO];
	[self setPinch:NO];
	[self setGateway:NO];
	[self setGatewayCode:-1];
	[self setKeyCode:-1];
	[self setArea:-1];
	[self setGatewayArea1:-1];
	[self setGatewayArea2:-1];
	[self setMatchingKey:NO];
	[self setHarder:NO];
//	[self.view setBackgroundColor:[UIColor colorWithRed:rand255() green:rand255() blue:rand255() alpha:1.0f]];
	return self;
}



@end
