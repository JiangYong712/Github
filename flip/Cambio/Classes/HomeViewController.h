//
//  HomeViewController.h
//  Cambio
//
//  Created by Paul Castronova on 6/6/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface HomeViewController : UIViewController<SlideNavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    CGFloat m_fMainScale;
    CGFloat m_fScreenWidth;
    CGFloat m_fScreenHeight;
    
    int m_nPrevSliderValue;
    int m_nTotalWordCount;
    
    BOOL m_bIsEnglish;
    BOOL m_bCalcuatedHeights;
    
    UIButton *m_pTranslateButton;
    UISlider *m_pDensitySlider;
    UIView   *m_pBottomControlView;
    
    NSMutableArray *m_pWordButtonArray;
    NSMutableArray *m_pCellHeightArray;
    
    UITableView *m_pWordListTableView;
}

- (void) wordSliderValueChanged:(float)value;

@end
