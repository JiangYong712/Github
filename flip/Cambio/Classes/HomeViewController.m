//
//  HomeViewController.m
//  Cambio
//
//  Created by Paul Castronova on 6/6/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import "HomeViewController.h"
#import "LeftMenuViewController.h"
#import "CambioWordSlider.h"
#import "TMXParser.h"
#import "AppDelegate.h"

#define kWordText @"WordText"
#define kIsEnglish @"IsEnglish"

@interface HomeViewController ()

@property (nonatomic, strong) NSMutableArray *m_pEnglishWordArray;
@property (nonatomic, strong) NSMutableArray *m_pSpanishWordArray;
@property (nonatomic, strong) NSMutableArray *m_pTableWordArray;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    m_fScreenWidth = screenRect.size.width;
    m_fScreenHeight = screenRect.size.height;
    
    //initialize global variables
    m_bIsEnglish = NO;
    m_nPrevSliderValue = 0;
    m_bCalcuatedHeights = NO;
    
    m_fMainScale = 1.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        m_fMainScale = 2.0;
    }
    
    [self updateNavTitleView];
    [self createBackground];
	
}

- (void)updateNavTitleView
{
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.2, m_fScreenWidth*0.05)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.045, m_fScreenWidth*0.04)];
    [titleImageView setImage:[UIImage imageNamed:@"home_icon.png"]];
    [navTitleView addSubview:titleImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(m_fScreenWidth*0.06, 0, m_fScreenWidth*0.14, m_fScreenWidth*0.05)];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:@"Home"];
    [titleLabel setFont:[UIFont systemFontOfSize:16*m_fMainScale]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navTitleView addSubview:titleLabel];
    
    self.navigationItem.titleView = navTitleView;
}

- (void)createBackground
{
    [self.view setBackgroundColor:kBackMainColor];
    //top convert button
    
    m_pBottomControlView = [[UIView alloc] initWithFrame:CGRectMake(0, m_fScreenHeight - m_fScreenWidth*0.21, m_fScreenWidth, m_fScreenWidth*0.21)];
    
    UIImageView *controllViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_pBottomControlView.frame.size.width, m_pBottomControlView.frame.size.height)];
    controllViewBack.image = [UIImage imageNamed:@"home_banner.png"];
    [m_pBottomControlView addSubview:controllViewBack];
    
    m_pTranslateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_pTranslateButton addTarget:self action:@selector(translateButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
    [m_pTranslateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [m_pTranslateButton.titleLabel setFont:[UIFont systemFontOfSize:16*m_fMainScale]];
    [m_pTranslateButton setBackgroundImage:[UIImage imageNamed:@"trans_button_container.png"] forState:UIControlStateNormal];
    [m_pTranslateButton setBackgroundImage:[UIImage imageNamed:@"trans_button_click_container.png"] forState:UIControlStateHighlighted];
    [m_pTranslateButton setFrame:CGRectMake(m_fScreenWidth*0.04, m_fScreenWidth*0.045, m_fScreenWidth*0.37, m_fScreenWidth*0.12)];
    
    [m_pBottomControlView addSubview:m_pTranslateButton];
    
    [m_pTranslateButton setTitle:@"Español" forState:UIControlStateNormal];
    [m_pTranslateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self addWordSlider];
    
    [self addWordListTable];
    
    [self.view addSubview:m_pBottomControlView];
}

- (void) addWordSlider
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:appDelegate.m_pSelectedTmxFile ofType:@"tmx"];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"tmx"];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"colors" ofType:@"tmx"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    NSArray *tmxDataArray = [TMXParser arrayForTMXString:content error:NULL];
    if (tmxDataArray != NULL) {
        
        CambioWordSlider *cambioWordSlider = [[CambioWordSlider alloc] initWithTMXArray:tmxDataArray];
        
        CGRect sliderFrame;
        sliderFrame = CGRectMake(m_fScreenWidth*0.45, m_fScreenWidth*0.07, m_fScreenWidth*0.5, m_fScreenWidth*0.08);
        [cambioWordSlider setFrame:sliderFrame];
        [cambioWordSlider setSuperViewDelegate:self];
        [m_pBottomControlView addSubview:cambioWordSlider];
        
        _m_pEnglishWordArray = [self convertWordsToparagraphArray:cambioWordSlider.m_pEnglishWords];
        _m_pSpanishWordArray = [self convertWordsToparagraphArray:cambioWordSlider.m_pSpanishWords];
    }
}

- (void) addWordListTable
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        m_pWordListTableView = [[UITableView alloc] initWithFrame:CGRectMake(m_fScreenWidth*0.04, m_fScreenHeight * 0.1f, m_fScreenWidth*0.92, m_fScreenHeight * 0.75f)
                                                            style:UITableViewStylePlain];
    }
    else {
        m_pWordListTableView = [[UITableView alloc] initWithFrame:CGRectMake(m_fScreenWidth*0.04, m_fScreenWidth * 0.25f, m_fScreenWidth*0.92, m_fScreenHeight - m_fScreenWidth * 0.46)
                                                            style:UITableViewStylePlain];
    }
    
    m_pWordListTableView.delegate = self;
    m_pWordListTableView.dataSource = self;
    m_pWordListTableView.allowsSelection = NO;
    [m_pWordListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:m_pWordListTableView];
    
    _m_pTableWordArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_m_pEnglishWordArray count]; i++) {
        NSArray *englishWordArray = [_m_pEnglishWordArray objectAtIndex:i];
        NSMutableArray *oneCellWordArray = [[NSMutableArray alloc] init];
        for (int j = 0; j < [englishWordArray count]; j++) {
            NSMutableDictionary *cellWordDict = [[NSMutableDictionary alloc] init];
            [cellWordDict setObject:[englishWordArray objectAtIndex:j] forKey:kWordText];
            [cellWordDict setObject:[NSNumber numberWithBool:YES] forKey:kIsEnglish];
            [oneCellWordArray addObject:cellWordDict];
        }
        [_m_pTableWordArray addObject:oneCellWordArray];
    }
    
    m_nTotalWordCount = 0;
    for (int i = 0; i < [_m_pTableWordArray count]; i++) {
        m_nTotalWordCount += [[_m_pTableWordArray objectAtIndex:i] count];
    }
    
    m_pCellHeightArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_m_pTableWordArray count]; i++) {
        [m_pCellHeightArray addObject:[NSNumber numberWithFloat:44.0f]];
    }
    
    [m_pWordListTableView reloadData];
}

- (void) addWordTextButtons:(UIView*)superView withTexts:(NSArray*)textArray withRow:(int)row
{
    float fontSize = 13*m_fMainScale;
    float wordStepSize = 4*m_fMainScale;
    float lineWidth = m_fScreenWidth*0.8;
    float lineHeight = 24*m_fMainScale;
    
    UIFont *normalFont = [UIFont systemFontOfSize:fontSize];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
    
    BOOL bIsMultiLine = NO;
    float wordXpos = 0;
    float wordYpos = 0;
    
    if (row == 0) {
        wordYpos = m_fScreenWidth * 0.06;
    }
    for (int i = 0; i < [textArray count]; i++) {
        NSDictionary *wordDict = [textArray objectAtIndex:i];
        
        NSString *wordText = [wordDict objectForKey:kWordText];
        BOOL bIsEnglish = [[wordDict objectForKey:kIsEnglish] boolValue];
        
        UIFont *wordFont;
        if (bIsEnglish) {
            wordFont = normalFont;
        }
        else {
            wordFont = boldFont;
        }
        
        float wordWidth = [self getStringWidth:wordText withFont:wordFont]+wordStepSize;
        
        float wordButtonWidth1 = 0;
        float wordButtonWidth2 = 0;
        NSString *wordString1;
        NSString *wordString2;
        if (wordWidth > lineWidth - wordXpos) {
            wordButtonWidth1 = lineWidth - wordXpos;
            wordString1 = [self stringByTruncatingToWidth:wordText withWidth:wordButtonWidth1 withFont:wordFont];
            
            wordButtonWidth2 = wordWidth - [self getStringWidth:wordString1 withFont:wordFont];
            wordString2 = [wordText stringByReplacingOccurrencesOfString:wordString1 withString:@""];
        }
        else {
            wordButtonWidth1 = wordWidth;
            wordString1 = wordText;
        }
        
        int tag = 10000 * row + i;
        
        UIButton *textButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [textButton1 addTarget:self action:@selector(textButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [textButton1 setTitle:wordString1 forState:UIControlStateNormal];
        [textButton1.titleLabel setFont:wordFont];
        textButton1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [textButton1 setTag:tag];
        [textButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        textButton1.frame = CGRectMake(m_fScreenWidth*0.07 + wordXpos, wordYpos, wordButtonWidth1, lineHeight);
        [textButton1 setOpaque:bIsEnglish];
        //textButton1.layer.borderWidth = 1.0;
        
        [superView addSubview:textButton1];
        
        if (wordButtonWidth2 > 0)
        {
            wordXpos = 0;
            wordYpos += lineHeight;
            
            UIButton *textButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [textButton2 addTarget:self action:@selector(textButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [textButton2 setTitle:wordString2 forState:UIControlStateNormal];
            [textButton2.titleLabel setFont:wordFont];
            textButton2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [textButton2 setTag:tag];
            [textButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            textButton2.frame = CGRectMake(m_fScreenWidth*0.07+wordXpos, wordYpos, wordButtonWidth2, lineHeight);
            [textButton2 setOpaque:bIsEnglish];
            //textButton2.layer.borderWidth = 1.0;
            [superView addSubview:textButton2];
            wordWidth = wordButtonWidth2;
            bIsMultiLine = YES;
        }
        else {
            bIsMultiLine = NO;
        }
        
        if (wordXpos+wordWidth < lineWidth * 0.9) {
            wordXpos = wordXpos+wordWidth;
            bIsMultiLine = YES;
        }
        else {
            wordXpos = 0;
            wordYpos += lineHeight;
        }
    }
    
    if (bIsMultiLine) {
        wordYpos += lineHeight;
    }
    
    [m_pCellHeightArray replaceObjectAtIndex:row withObject:[NSNumber numberWithFloat:wordYpos]];
    if (row == [_m_pTableWordArray count] - 1 && !m_bCalcuatedHeights) {
        [m_pWordListTableView reloadData];
        m_bCalcuatedHeights = YES;
    }
}

- (void) translateOneWord:(BOOL)bIsEnglish Index:(int)wordIdx
{
    NSString *changedWordText;
    
    int cellIdx = wordIdx / 10000;
    int wordTextIdx = wordIdx % 10000;
    
    if (bIsEnglish) {
        changedWordText = [[_m_pSpanishWordArray objectAtIndex:cellIdx] objectAtIndex:wordTextIdx];
    }
    else {
        changedWordText = [[_m_pEnglishWordArray objectAtIndex:cellIdx] objectAtIndex:wordTextIdx];
    }
    
    NSMutableArray *selWordCellArray = [_m_pTableWordArray objectAtIndex:cellIdx];
    NSMutableDictionary *changedWordDict = [selWordCellArray objectAtIndex:wordTextIdx];
    
    [changedWordDict setObject:changedWordText forKey:kWordText];
    [changedWordDict setObject:[NSNumber numberWithBool:!bIsEnglish] forKey:kIsEnglish];
    
    [selWordCellArray replaceObjectAtIndex:wordTextIdx withObject:changedWordDict];
    [_m_pTableWordArray replaceObjectAtIndex:cellIdx withObject:selWordCellArray];
    
    [m_pWordListTableView reloadData];
}

- (void) translateAllWords:(BOOL)bIsEnglish
{
    NSMutableArray *translatedArray;
    if (bIsEnglish) {
        [m_pTranslateButton setTitle:@"English" forState:UIControlStateNormal];
        translatedArray = _m_pSpanishWordArray;
    }
    else {
        [m_pTranslateButton setTitle:@"Español" forState:UIControlStateNormal];
        translatedArray = _m_pEnglishWordArray;
    }
    
    for (int i = 0; i < [translatedArray count]; i++) {
        NSArray *transWordArray = [translatedArray objectAtIndex:i];
        NSMutableArray *oneCellWordArray = [_m_pTableWordArray objectAtIndex:i];
        [oneCellWordArray removeAllObjects];
        for (int j = 0; j < [transWordArray count]; j++) {
            NSMutableDictionary *cellWordDict = [[NSMutableDictionary alloc] init];
            [cellWordDict setObject:[transWordArray objectAtIndex:j] forKey:kWordText];
            [cellWordDict setObject:[NSNumber numberWithBool:!bIsEnglish] forKey:kIsEnglish];
            [oneCellWordArray addObject:cellWordDict];
        }
        [_m_pTableWordArray replaceObjectAtIndex:i withObject:oneCellWordArray];
    }
    
    m_bCalcuatedHeights = NO;
    
    [m_pWordListTableView reloadData];
}

- (int) convertToTableIdx:(int)wordIdx
{
    int tableIdx = 0;
    int totalIdx = 0;
    for (int i = 0; i < [_m_pTableWordArray count]; i++) {
        totalIdx += [[_m_pTableWordArray objectAtIndex:i] count];
        if (wordIdx < totalIdx) {
            tableIdx += wordIdx;
            break;
        }
        tableIdx += 10000 - [[_m_pTableWordArray objectAtIndex:i] count];
    }
    
    return tableIdx;
}

- (void) wordSliderValueChanged:(float)value
{
    int sliderValue = (int)(value * m_nTotalWordCount);
    
    if (sliderValue < m_nTotalWordCount) {
        
        for (int i = 0; i < sliderValue; i++) {
            [self translateOneWord:!m_bIsEnglish Index:[self convertToTableIdx:i]];
        }
        
        if (m_nPrevSliderValue > sliderValue) {
            for (int i = sliderValue; i < m_nPrevSliderValue; i++) {
                [self translateOneWord:m_bIsEnglish Index:[self convertToTableIdx:i]];
            }
        }
        if (m_nPrevSliderValue != sliderValue) {
            m_nPrevSliderValue = sliderValue;
        }
    }
}

#pragma mark - utility functions

- (NSMutableArray*) convertWordsToparagraphArray:(NSArray*)orgWordArray
{
    NSMutableArray *paragraphArray = [[NSMutableArray alloc] init];
    NSMutableArray *wordArray = [[NSMutableArray alloc] init];
    for (NSString *wordText in orgWordArray) {
        if ([wordText isEqualToString:@"\\n"]) {
            [paragraphArray addObject:wordArray];
            
            wordArray = [[NSMutableArray alloc] init];
        }
        else {
            [wordArray addObject:wordText];
        }
    }
    
    if (![[orgWordArray lastObject] isEqualToString:@"\\n"]) {
        [paragraphArray addObject:wordArray];
    }
    
    return paragraphArray;
}

- (CGFloat) getStringWidth:(NSString*)text withFont:(UIFont*)font
{
    CGFloat textWidth;
#ifdef __IPHONE_7_0
    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    textWidth = textSize.width;
#else
    CGSize textSize = [text sizeWithFont:wordFont];
    textWidth = textSize.width;
#endif
    
    return textWidth;
}

- (NSString*) stringByTruncatingToWidth:(NSString*)origString withWidth:(CGFloat)width withFont:(UIFont*)font
{
    int min = 1, max = (int)origString.length;
    int targetPos = 0;
    while (min < max) {
        
        NSString *currentString = [origString substringWithRange:NSMakeRange(0, min)];
        if ([[currentString substringFromIndex:[currentString length] -1] isEqualToString:@" "]) {
            targetPos = min;
        }
        
        CGFloat stringWidth = [self getStringWidth:currentString withFont:font];
        
        if (stringWidth < width) {
            min += 1;
        }
        else {
            break;
        }
    }
    
    return [origString substringWithRange:NSMakeRange(0, targetPos)];
}

#pragma mark - button actions

- (void) translateButtonCliked:(UIButton*)sender
{
    if (m_bIsEnglish) {
        m_bIsEnglish = NO;
    }
    else {
        m_bIsEnglish = YES;
    }
    
    [self translateAllWords:m_bIsEnglish];
}

- (void) textButtonClicked:(UIButton*)sender
{
    int buttonIdx = (int)sender.tag;
    BOOL bIsEnglish = sender.opaque;
    
    [self translateOneWord:bIsEnglish Index:buttonIdx];
}

#pragma mark - UITableViewDataSource
// number of section(s)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = [[m_pCellHeightArray objectAtIndex:indexPath.row] floatValue];
    return cellHeight;
}

// number of row in the section
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [_m_pTableWordArray count];
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    } else {
        for (UIView *subView in [[cell contentView] subviews]) {
            [subView removeFromSuperview];
        }
    }
    
    // Configure the cell...
    NSArray *wordTextArray = [_m_pTableWordArray objectAtIndex:indexPath.row];
    [self addWordTextButtons:cell.contentView withTexts:wordTextArray withRow:(int)indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}


@end
