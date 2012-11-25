//
//  FTArea.h
//  Food Trap
//
//  Created by Steven Silvey on 11/24/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTArea : NSObject

@property (nonatomic, assign) int area;
@property (nonatomic, retain) NSMutableArray *deniedGateways;

/// For analyzing an area
@property (nonatomic, retain) NSMutableArray *arrKeys;
@property (nonatomic, retain) NSMutableArray *arrAreas;
@property (nonatomic, retain) NSMutableArray *gateways;
@property (nonatomic, assign) BOOL canGetLockedOutOf;

@end
