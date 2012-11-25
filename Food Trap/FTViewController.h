//
//  FTViewController.h
//  Food Trap
//
//  Created by Steven Silvey on 11/24/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTPlayer.h"
#import "FTTile.h"

#define MAXY	14
#define MAXX	10
#define TILEW	32
#define TILEH	32

// Small
//#define MAXY	24
//#define MAXX	16
//#define TILEW	20
//#define TILEH	20

@interface FTViewController : UIViewController <DDTileTappedDelegate>

@property (nonatomic, retain) NSArray *level;
@property (nonatomic, retain) NSArray *openTiles;

@property (nonatomic, retain) NSMutableArray *allAreas;
@property (nonatomic, retain) NSMutableArray *gateways;
@property (nonatomic, retain) NSMutableArray *collectedKeys;
@property (nonatomic, retain) NSMutableArray *arrEnemies;
@property (nonatomic, retain) NSMutableArray *arrOpenTiles;

@property (nonatomic, strong) FTPlayer *player;



@property (nonatomic, assign) BOOL test;

@end
