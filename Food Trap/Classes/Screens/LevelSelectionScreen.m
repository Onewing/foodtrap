//
//  LevelSelectionScreen.m
//  Food Trap
//
//  Created by Steven Silvey on 2/21/13.
//  Copyright (c) 2013 Rockfish. All rights reserved.
//

#import "LevelSelectionScreen.h"
#import "Level.h"

@interface LevelSelectionScreen ()

@end

@implementation LevelSelectionScreen

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark IBActions
-(IBAction)startLevel:(id)sender {    
    if([sender isKindOfClass:[UIButton class]]) {
        UIButton *buttonTapped = (UIButton *)sender;
        
        @try {
            Level *vc = [[Level alloc] initWithNibName:[NSString stringWithFormat:@"Level1-%d", buttonTapped.tag] bundle:[NSBundle mainBundle]];
            [[Game sharedGame] show:vc];
        }
        @catch (NSException *exception) {
            NSLog(@"Error trying to read level!");
        }
        @finally {
            
        }
        
    }
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIScrollView Delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.scrollContent;// [[self.scrollLayer subviews] objectAtIndex:0];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIView *subView = self.scrollContent;//[scrollView.subviews objectAtIndex:0];
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Life Cycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /// Setup the zooming/scrolling stuff
    [self.scrollLayer setContentSize:self.scrollContent.frame.size];
    [self.scrollLayer addSubview:self.scrollContent];
    [self.scrollLayer setMaximumZoomScale:1.5f];
    [self.scrollLayer setMinimumZoomScale:0.5f];
    [self.scrollLayer setZoomScale:1.0f];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
