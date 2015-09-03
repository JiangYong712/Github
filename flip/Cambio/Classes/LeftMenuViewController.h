//
//  LeftMenuViewController.h
//  Cambio
//
//  Created by Paul Castronova on 7/4/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface LeftMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    BOOL bIsFirstOpened;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;

@end
