//
//  LevelLayer.m
//  Food Trap
//
//  Created by Steven Silvey on 2/11/13.
//  Copyright (c) 2013 Rockfish. All rights reserved.
//

#import "LevelLayer.h"

@implementation LevelLayer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LayerTouched" object:nil userInfo:[NSDictionary dictionaryWithObject:[[event allTouches] anyObject] forKey:@"layer"]];
}

@end
