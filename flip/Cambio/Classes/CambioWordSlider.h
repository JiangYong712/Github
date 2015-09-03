//
//  CambioWordSlider.h
//  Cambio
//
//  Created by Paul Castronova on 7/4/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CambioWordSlider : UISlider
{
    id superViewDelegate;
    
    NSMutableArray *m_pEnglishWords;
    NSMutableArray *m_pSpanishWords;
}

@property (nonatomic, strong) NSMutableArray *m_pEnglishWords;
@property (nonatomic, strong) NSMutableArray *m_pSpanishWords;

- (id) initWithTMXArray:(NSArray*)tmxDataArray;
- (void) setSuperViewDelegate:(id)delegate;
- (void) setSliderFrame:(CGRect)sliderFrame;

@end
