//
//  SlideNavigationContorllerAnimatorScaleAndFade.h
//  Cambio
//
//  Created by Paul Castronova on 7/4/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SlideNavigationContorllerAnimator.h"

@interface SlideNavigationContorllerAnimatorScaleAndFade : NSObject <SlideNavigationContorllerAnimator>

- (id)initWithMaximumFadeAlpha:(CGFloat)maximumFadeAlpha fadeColor:(UIColor *)fadeColor andMinimumScale:(CGFloat)minimumScale;

@end
