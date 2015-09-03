//
//  StoreViewController.h
//  Cambio
//
//  Created by Paul Castronova on 7/7/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import "StoreViewController.h"
#import "AppDelegate.h"

@implementation StoreViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    m_fScreenWidth = screenRect.size.width;
    m_fScreenHeight = screenRect.size.height;
    
    m_fMainScale = 1.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        m_fMainScale = 2.0;
    }
    
    [self.view setBackgroundColor:kBackMainColor];
    
    [self updateNavTitleView];
    [self addControlPannel];
    [self addBookshelfList];
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (void)updateNavTitleView
{
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.2, m_fScreenWidth*0.05)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -m_fScreenWidth*0.005, m_fScreenWidth*0.035, m_fScreenWidth*0.06)];
    [titleImageView setImage:[UIImage imageNamed:@"store_icon.png"]];
    [navTitleView addSubview:titleImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(m_fScreenWidth*0.04, 0, m_fScreenWidth*0.14, m_fScreenWidth*0.05)];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:@"Store"];
    [titleLabel setFont:[UIFont systemFontOfSize:16*m_fMainScale]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navTitleView addSubview:titleLabel];
    
    self.navigationItem.titleView = navTitleView;
}

- (void) addControlPannel
{
    m_fControlPanelHeight = m_fScreenWidth*0.23;
    
    UIView *panelContainer = [[UIView alloc] initWithFrame:CGRectMake(0, m_fScreenWidth*0.2, m_fScreenWidth, m_fControlPanelHeight)];
    [self.view addSubview:panelContainer];
    
    UIImageView *panelBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, panelContainer.frame.size.width, panelContainer.frame.size.height)];
    panelBack.image = [UIImage imageNamed:@"bookshelf_topbanner.png"];
    [panelContainer addSubview:panelBack];
    
    UIButton *priceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [priceButton addTarget:self action:@selector(onClickPriceButton:) forControlEvents:UIControlEventTouchUpInside];
    priceButton.frame = CGRectMake(m_fScreenWidth*0.14, m_fScreenWidth*0.06, m_fScreenWidth*0.275, m_fScreenWidth*0.1125);
    [priceButton setImage:[UIImage imageNamed:@"store_price.png"] forState:UIControlStateNormal];
    [panelContainer addSubview:priceButton];
    
    UIButton *categoriesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoriesButton addTarget:self action:@selector(onClickCategoriesButton:) forControlEvents:UIControlEventTouchUpInside];
    categoriesButton.frame = CGRectMake(m_fScreenWidth*0.5, m_fScreenWidth*0.06, m_fScreenWidth*0.415, m_fScreenWidth*0.1125);
    [categoriesButton setImage:[UIImage imageNamed:@"bookshelf_categories.png"] forState:UIControlStateNormal];
    [panelContainer addSubview:categoriesButton];
    
}

- (void) addBookshelfList
{
    _scrollView.frame = CGRectMake(0, m_fControlPanelHeight, m_fScreenWidth, m_fScreenHeight-m_fControlPanelHeight);
    
    NSMutableArray *bookPriceArray = [[NSMutableArray alloc] init];
    [bookPriceArray addObject:@"$2.95"];
    [bookPriceArray addObject:@"$3.80"];
    [bookPriceArray addObject:@"$2.20"];
    [bookPriceArray addObject:@"$1.95"];
    [bookPriceArray addObject:@"$2.65"];
    [bookPriceArray addObject:@"$1.50"];
    
    int rowCount = 3;
    CGFloat imageWidth = m_fScreenWidth*0.28;
    CGFloat imageHeight = m_fScreenWidth*0.28;
    CGFloat imageXoffset = m_fScreenWidth*0.05;
    CGFloat imageYoffset = m_fScreenHeight*0.15;
    for (int i = 0; i < 6; i++) {
        
        UIButton *bookImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bookImageButton addTarget:self action:@selector(bookImageButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
        [bookImageButton setBackgroundImage:[UIImage imageNamed:@"default_book.png"] forState:UIControlStateNormal];
        [bookImageButton setTag:i];
        
        [bookImageButton setFrame:CGRectMake(m_fScreenWidth*0.03 + (imageWidth+imageXoffset) * (i%rowCount), m_fScreenHeight*0.05 + (imageHeight+imageYoffset) * (i/rowCount),
                                             imageWidth, imageHeight)];
        
        [_scrollView addSubview:bookImageButton];
        
        UILabel *bookTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageWidth, m_fScreenWidth*0.1)];
        bookTitleLabel.center = CGPointMake(bookImageButton.center.x, bookImageButton.center.y + imageHeight*0.7);
        [bookTitleLabel setTextColor:[UIColor blackColor]];
        [bookTitleLabel setFont:[UIFont systemFontOfSize:15*m_fMainScale]];
        [bookTitleLabel setText:[NSString stringWithFormat:@"Book %d", i+1]];
        bookTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        [_scrollView addSubview:bookTitleLabel];
        
        UILabel *bookPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageWidth, m_fScreenWidth*0.1)];
        bookPriceLabel.center = CGPointMake(bookImageButton.center.x, bookTitleLabel.center.y + m_fScreenWidth*0.1);
        [bookPriceLabel setTextColor:[UIColor redColor]];
        [bookPriceLabel setText:[bookPriceArray objectAtIndex:i]];
        [bookPriceLabel setFont:[UIFont systemFontOfSize:15*m_fMainScale]];
        bookPriceLabel.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:bookPriceLabel];
    }
}

#pragma mark - custom alert

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

- (UIView *)createDemoView
{
    UIView *bookView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.7, m_fScreenWidth*1.3)];
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.7, m_fScreenWidth*0.5)];
    [titleImageView setImage:[UIImage imageNamed:@"dialog_default_image.png"]];
    [bookView addSubview:titleImageView];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(closeButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"dialog_close_button.png"] forState:UIControlStateNormal];
    [closeButton setFrame:CGRectMake(m_fScreenWidth*0.63, m_fScreenWidth*0.02, m_fScreenWidth*0.05, m_fScreenWidth*0.05)];
    [bookView addSubview:closeButton];
    
    UILabel *bookTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.6, m_fScreenWidth*0.2)];
    bookTitleLabel.center = CGPointMake(titleImageView.center.x, titleImageView.center.y + m_fScreenWidth*0.38);
    bookTitleLabel.numberOfLines = 0;
    [bookTitleLabel setTextColor:[UIColor blackColor]];
    [bookTitleLabel setText:@"Little Red\n Riding Hood"];
    [bookTitleLabel setFont:[UIFont boldSystemFontOfSize:20*m_fMainScale]];
    bookTitleLabel.textAlignment = NSTextAlignmentCenter;
    [bookView addSubview:bookTitleLabel];
    
    UILabel *bookDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.6, m_fScreenWidth*0.4)];
    bookDescLabel.center = CGPointMake(bookTitleLabel.center.x, bookTitleLabel.center.y + m_fScreenWidth*0.22);
    bookDescLabel.numberOfLines = 0;
    bookDescLabel.textAlignment = NSTextAlignmentLeft;
    [bookDescLabel setTextColor:[UIColor blackColor]];
    [bookDescLabel setText:@"The story revolves around a girl called Little Red Riding Hood. The girl walks through the woods to deliver food to her sickly grandmother(wine and cake depending on the translation). In the Grimm's version, she had the order from her mother to stay"];
    [bookDescLabel setFont:[UIFont systemFontOfSize:10*m_fMainScale]];
    bookDescLabel.textAlignment = NSTextAlignmentLeft;
    [bookView addSubview:bookDescLabel];
    
    UILabel *bookPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.6, m_fScreenWidth*0.2)];
    bookPriceLabel.center = CGPointMake(titleImageView.center.x, m_fScreenWidth*1.05);
    [bookPriceLabel setTextColor:[UIColor redColor]];
    [bookPriceLabel setText:@"$2.95"];
    [bookPriceLabel setFont:[UIFont boldSystemFontOfSize:24*m_fMainScale]];
    bookPriceLabel.textAlignment = NSTextAlignmentCenter;
    [bookView addSubview:bookPriceLabel];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton addTarget:self action:@selector(buyButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
    [buyButton setBackgroundImage:[UIImage imageNamed:@"store_buy_button.png"] forState:UIControlStateNormal];
    [buyButton setFrame:CGRectMake(m_fScreenWidth*0.21, m_fScreenWidth*1.14, m_fScreenWidth*0.275, m_fScreenWidth*0.1125)];
    [bookView addSubview:buyButton];
    
    return bookView;
}

#pragma mark - button actions

- (void) bookImageButtonCliked:(UIButton*)sender
{
    // Here we need to pass a full frame
    m_pAlertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [m_pAlertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [m_pAlertView setButtonTitles:NULL];
    [m_pAlertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [m_pAlertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];
    
    [m_pAlertView setUseMotionEffects:true];
    
    // And launch the dialog
    [m_pAlertView show];
}

- (void) closeButtonCliked:(UIButton*)sender
{
    if (m_pAlertView) {
        [m_pAlertView close];
    }
}

- (void) buyButtonCliked:(UIButton*)sender
{

}

- (IBAction)onClickPriceButton:(id)sender
{
    
}

- (IBAction)onClickCategoriesButton:(id)sender
{
    
}


@end
