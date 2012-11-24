//
//  DDEntity.h
//  Food Trap
//
//  Created by Steven Silvey on 3/26/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTTile.h"

@interface FTEntity : UIViewController

@property (nonatomic, assign) NSInteger x,y;

-(void)moveTo:(FTTile *)tile;

@end
