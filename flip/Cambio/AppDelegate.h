//
//  AppDelegate.h
//  Cambio
//
//  Created by Paul Castronova on 6/6/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "LeftMenuViewController.h"

#define kTitleMainColor [UIColor colorWithRed:0 green:176.0/255 blue:1.0 alpha:1.0]
#define kLeftTitleColor [UIColor colorWithRed:53.0/255 green:83.0/255 blue:113.0/255 alpha:1.0]
#define kBackMainColor [UIColor colorWithRed:236.0/255 green:237.0/255 blue:238.0/255 alpha:1.0]
#define kLeftMenuBackColor [UIColor colorWithRed:28.0/255 green:34.0/255 blue:44.0/255 alpha:1.0] 

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *m_pSelectedTmxFile;

@end
