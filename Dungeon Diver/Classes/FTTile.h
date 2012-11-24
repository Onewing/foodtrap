//
//  DDTile.h
//  Food Trap
//
//  Created by Steven Silvey on 3/19/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum pathState {
	START	= 0,
	END		= 1,
	OPEN	= 2,
	PENDING	= 3,
	DEADEND	= 4,
	CLOSED	= 5,
	NO_STATE = 6,
	TEST = 7
} PATH_STATE;

@class FTTile;

@protocol DDTileTappedDelegate <NSObject>

-(void)tileTapped:(FTTile *)tile;

@end


@interface FTTile : UIViewController

@property (nonatomic, assign) id<DDTileTappedDelegate> delegate;
@property (nonatomic, retain) IBOutlet UILabel *lblSteps;
@property (nonatomic, strong) IBOutlet UIView *vDarkness;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isComplete;

@property (nonatomic, assign) NSUInteger x, y;
@property (nonatomic, assign) CGFloat visibility;
@property (nonatomic, assign) BOOL discovered;
@property (nonatomic, assign) BOOL pinch;
@property (nonatomic, assign) BOOL gateway;
@property (nonatomic, assign) int gatewayCode;
@property (nonatomic, assign) int keyCode;
@property (nonatomic, assign) bool matchingKey;
@property (nonatomic, assign) BOOL harder;
@property (nonatomic, assign) BOOL used;
@property (nonatomic, assign) NSInteger area, gatewayArea1, gatewayArea2;


@property (nonatomic, assign) PATH_STATE state;
-(BOOL)checkIfOpen;

-(void)setColor:(UIColor *)col;
-(void)updateGateway:(NSInteger)newArea;


@end


@interface DDTileView : UIView

@property (nonatomic, retain) IBOutlet FTTile *tile;

@end
