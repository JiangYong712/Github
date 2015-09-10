//
//  StoreViewController.h
//  Cambio
//
//  Created by Paul Castronova on 7/4/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "CustomIOSAlertView.h"

@interface StoreViewController : UIViewController <SlideNavigationControllerDelegate, CustomIOSAlertViewDelegate>
{
    CGFloat m_fMainScale;
    CGFloat m_fScreenWidth;
    CGFloat m_fScreenHeight;
    CGFloat m_fControlPanelHeight;
    
    CustomIOSAlertView *m_pAlertView;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *m_pBookShelfListArray;

@end
