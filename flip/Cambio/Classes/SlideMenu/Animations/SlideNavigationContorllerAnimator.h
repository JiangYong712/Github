//
//  SlideNavigationController.h
//  Cambio
//
//  Created by Paul Castronova on 7/4/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SlideNavigationController.h"

@protocol SlideNavigationContorllerAnimator <NSObject>

// Initial state of the view before animation starts
// This gets called right before the menu is about to reveal
- (void)prepareMenuForAnimation:(Menu)menu;

// Animate the view based on the progress (progress is between 0 and 1)
- (void)animateMenu:(Menu)menu withProgress:(CGFloat)progress;

// Gets called ff for any the instance of animator is being change
// You should make any cleanup that is needed
- (void)clear;

@end
