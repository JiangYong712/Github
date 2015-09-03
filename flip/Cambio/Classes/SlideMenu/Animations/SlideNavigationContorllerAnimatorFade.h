//
//  SlideNavigationContorllerAnimatorFade.h
//  Cambio
//
//  Created by Paul Castronova on 7/4/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SlideNavigationContorllerAnimator.h"

@interface SlideNavigationContorllerAnimatorFade : NSObject <SlideNavigationContorllerAnimator>

@property (nonatomic, assign) CGFloat maximumFadeAlpha;
@property (nonatomic, strong) UIColor *fadeColor;

- (id)initWithMaximumFadeAlpha:(CGFloat)maximumFadeAlpha andFadeColor:(UIColor *)fadeColor;

@end
