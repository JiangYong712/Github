//
//  CambioWordSlider.m
//  Cambio
//
//  Created by Paul Castronova on 7/4/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import "CambioWordSlider.h"
#import "HomeViewController.h"
#import "TMXParser.h"

@implementation CambioWordSlider

@synthesize m_pEnglishWords;
@synthesize m_pSpanishWords;

- (id) initWithTMXArray:(NSArray*)tmxDataArray
{
    self = [super init];
    {
        [self addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self setThumbImage:[UIImage imageNamed:@"scroll_ball.png"] forState:UIControlStateNormal];
        
        UIImage *sliderTrackImage = [[UIImage imageNamed:@"scroll_bar.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
        [self setMinimumTrackImage:sliderTrackImage forState:UIControlStateNormal];
        [self setMaximumTrackImage:sliderTrackImage forState:UIControlStateNormal];
        
        self.minimumValue = 0.0;
        self.maximumValue = 1.0;
        self.continuous = YES;
        self.value = 0.0f;
        
        [self parseWordsFromTMXArray:tmxDataArray];
    }
    
    return self;
}

- (void) setSliderFrame:(CGRect)sliderFrame
{
    [self setFrame:sliderFrame];
}

- (void) setSuperViewDelegate:(id)delegate
{
    superViewDelegate = delegate;
}

- (void) parseWordsFromTMXArray:(NSArray*)tmxDataArray
{
    m_pEnglishWords = [[NSMutableArray alloc] init];
    m_pSpanishWords = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [tmxDataArray count]; i++) {
        TMXData *tmxData = [tmxDataArray objectAtIndex:i];
        
        if ([tmxData.tuvArray count] > 0) {
            for (int j = 0; j < [tmxData.tuvArray count]; j++) {
                NSDictionary *tuvDictionary = [tmxData.tuvArray objectAtIndex:j];
                NSDictionary *segDictionary = [tuvDictionary objectForKey:@"seg"];
                NSString *segText = [segDictionary objectForKey:kXMLReaderTextNodeKey];
                NSString *newSting = [[segText componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
                NSString *trimmedSeg = [newSting stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                if ([[tuvDictionary objectForKey:@"xml:lang"] isEqualToString:@"en"]) {
                    [m_pEnglishWords addObject:trimmedSeg];
                }
                else if ([[tuvDictionary objectForKey:@"xml:lang"] isEqualToString:@"es"]) {
                    [m_pSpanishWords addObject:trimmedSeg];
                }
                
            }
        }
    }
}

- (void) sliderValueChanged:(UISlider *)sender
{
    [(HomeViewController*)superViewDelegate wordSliderValueChanged:sender.value];
}

@end
