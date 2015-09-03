//
//  SlideNavigationContorllerAnimatorScale.h
//  Cambio
//
//  Created by Paul Castronova on 7/4/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SlideNavigationContorllerAnimator.h"

@interface SlideNavigationContorllerAnimatorScale : NSObject <SlideNavigationContorllerAnimator>

@property (nonatomic, assign) CGFloat minimumScale;

- (id)initWithMinimumScale:(CGFloat)minimumScale;

@end
