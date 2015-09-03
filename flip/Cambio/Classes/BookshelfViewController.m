//
//  BookshelfViewController.h
//  Cambio
//
//  Created by Paul Castronova on 7/7/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import "BookshelfViewController.h"
#import "AppDelegate.h"

@implementation BookshelfViewController

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
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.3, m_fScreenWidth*0.05)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, m_fScreenWidth*0.005, m_fScreenWidth*0.05, m_fScreenWidth*0.04)];
    [titleImageView setImage:[UIImage imageNamed:@"bookshelf_icon.png"]];
    [navTitleView addSubview:titleImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(m_fScreenWidth*0.06, 0, m_fScreenWidth*0.24, m_fScreenWidth*0.05)];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:@"Bookshelf"];
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
    
    UIButton *dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateButton addTarget:self action:@selector(onClickDateButton:) forControlEvents:UIControlEventTouchUpInside];
    dateButton.frame = CGRectMake(m_fScreenWidth*0.14, m_fScreenWidth*0.06, m_fScreenWidth*0.275, m_fScreenWidth*0.1125);
    [dateButton setImage:[UIImage imageNamed:@"bookshelf_date.png"] forState:UIControlStateNormal];
    [panelContainer addSubview:dateButton];
    
    UIButton *categoriesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoriesButton addTarget:self action:@selector(onClickCategoriesButton:) forControlEvents:UIControlEventTouchUpInside];
    categoriesButton.frame = CGRectMake(m_fScreenWidth*0.5, m_fScreenWidth*0.06, m_fScreenWidth*0.415, m_fScreenWidth*0.1125);
    [categoriesButton setImage:[UIImage imageNamed:@"bookshelf_categories.png"] forState:UIControlStateNormal];
    [panelContainer addSubview:categoriesButton];
    
}

- (void) addBookshelfList
{
    _scrollView.frame = CGRectMake(0, m_fControlPanelHeight, m_fScreenWidth, m_fScreenHeight-m_fControlPanelHeight);
    
    int rowCount = 3;
    CGFloat imageWidth = m_fScreenWidth*0.28;
    CGFloat imageHeight = m_fScreenWidth*0.28;
    CGFloat imageXoffset = m_fScreenWidth*0.05;
    CGFloat imageYoffset = m_fScreenHeight*0.12;
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
    UIView *bookView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.7, m_fScreenWidth*1.1)];
    [bookView setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.7, m_fScreenWidth*0.5)];
    [titleImageView setImage:[UIImage imageNamed:@"dialog_default_image.png"]];
    [bookView addSubview:titleImageView];
    
    UILabel *bookTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.6, m_fScreenWidth*0.2)];
    bookTitleLabel.center = CGPointMake(titleImageView.center.x, titleImageView.center.y + m_fScreenWidth*0.38);
    bookTitleLabel.numberOfLines = 0;
    [bookTitleLabel setTextColor:[UIColor blackColor]];
    [bookTitleLabel setText:@"Little Red\n Riding Hood"];
    [bookTitleLabel setFont:[UIFont boldSystemFontOfSize:20*m_fMainScale]];
    bookTitleLabel.textAlignment = NSTextAlignmentCenter;
    [bookView addSubview:bookTitleLabel];
    
    UILabel *bookDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth*0.6, m_fScreenWidth*0.4)];
    bookDescLabel.center = CGPointMake(bookTitleLabel.center.x, m_fScreenWidth*0.83);
    [bookDescLabel setTextColor:[UIColor grayColor]];
    [bookDescLabel setText:@"Are you going to read this book?"];
    [bookDescLabel setFont:[UIFont systemFontOfSize:12*m_fMainScale]];
    bookDescLabel.textAlignment = NSTextAlignmentCenter;
    [bookView addSubview:bookDescLabel];
    
    UIButton *yesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [yesButton addTarget:self action:@selector(onClickDialogYesButton:) forControlEvents:UIControlEventTouchUpInside];
    [yesButton setBackgroundImage:[UIImage imageNamed:@"dialog_yes_button.png"] forState:UIControlStateNormal];
    [yesButton setFrame:CGRectMake(m_fScreenWidth*0.06, m_fScreenWidth*0.92, m_fScreenWidth*0.275, m_fScreenWidth*0.1125)];
    [bookView addSubview:yesButton];
    
    UIButton *noButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noButton addTarget:self action:@selector(onClickDialogNoButton:) forControlEvents:UIControlEventTouchUpInside];
    [noButton setBackgroundImage:[UIImage imageNamed:@"dialog_no_button.png"] forState:UIControlStateNormal];
    [noButton setFrame:CGRectMake(m_fScreenWidth*0.36, m_fScreenWidth*0.92, m_fScreenWidth*0.275, m_fScreenWidth*0.1125)];
    [bookView addSubview:noButton];
    
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


- (IBAction)onClickDateButton:(id)sender
{
    
}

- (IBAction)onClickCategoriesButton:(id)sender
{
    
}

- (IBAction)onClickDialogYesButton:(id)sender
{
    if (m_pAlertView) {
        [m_pAlertView close];
    }
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:YES
                                                                     andCompletion:nil];
}

- (IBAction)onClickDialogNoButton:(id)sender
{
    if (m_pAlertView) {
        [m_pAlertView close];
    }
}

@end
