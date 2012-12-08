//
//  Screen.h
//  Food Trap
//
//  Created by Steven Silvey on 12/8/12.
//  Copyright (c) 2012 Rockfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"


@interface Screen : Entity

-(void)display:(UIView *)something;
-(void)setup;

@end
