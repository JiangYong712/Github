//
//  LoginViewController.m
//  Cambio
//
//  Created by Paul Castronova on 8/27/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"

@interface LoginViewController ()


@end


@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    m_fScreenWidth = screenRect.size.width;
    m_fScreenHeight = screenRect.size.height;
    
    
    m_fMainScale = 1.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        m_fMainScale = 2.0;
    }
    
    self.title = @"Login";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.11 green:0.13 blue:0.17 alpha:1.0]];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self createBackground];
    
}

- (void)createBackground
{
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_fScreenWidth, m_fScreenHeight)];
    backgroundImage.image = [UIImage imageNamed:@"login_background.png"];
    [self.view addSubview:backgroundImage];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(m_fScreenWidth*0.26, m_fScreenHeight*0.28, m_fScreenWidth*0.48, m_fScreenWidth*0.2)];
    logoImage.image = [UIImage imageNamed:@"login_logo.png"];
    [self.view addSubview:logoImage];
    
    UIView *usernameContainer = [[UIView alloc] initWithFrame:CGRectMake(m_fScreenWidth*0.12, m_fScreenHeight*0.46, m_fScreenWidth*0.76, m_fScreenWidth*0.13)];
    [self.view addSubview:usernameContainer];
    
    UIImageView *usernameBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, usernameContainer.frame.size.width, usernameContainer.frame.size.height)];
    usernameBack.image = [UIImage imageNamed:@"username_container.png"];
    [usernameContainer addSubview:usernameBack];
    
    UITextField *usernameField = [[UITextField alloc] initWithFrame:CGRectMake(usernameContainer.frame.size.width*0.1, 0, usernameContainer.frame.size.width*0.8, usernameContainer.frame.size.height)];
    usernameField.placeholder = @"Username";
    usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    usernameField.returnKeyType = UIReturnKeyDone;
    [usernameContainer addSubview:usernameField];
    
    UIView *passwordContainer = [[UIView alloc] initWithFrame:CGRectMake(m_fScreenWidth*0.12, m_fScreenHeight*0.57, m_fScreenWidth*0.76, m_fScreenWidth*0.13)];
    [self.view addSubview:passwordContainer];
    
    UIImageView *passwordBack= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, passwordContainer.frame.size.width, passwordContainer.frame.size.height)];
    passwordBack.image = [UIImage imageNamed:@"password_container.png"];
    [passwordContainer addSubview:passwordBack];
    
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(passwordContainer.frame.size.width*0.1, 0, passwordContainer.frame.size.width*0.8, passwordContainer.frame.size.height)];
    passwordField.placeholder = @"Password";
    passwordField.secureTextEntry = YES;
    passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordField.returnKeyType = UIReturnKeyDone;
    [passwordContainer addSubview:passwordField];
    
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton addTarget:self action:@selector(onClickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.frame = CGRectMake(m_fScreenWidth*0.285, m_fScreenHeight*0.7, m_fScreenWidth*0.43, m_fScreenWidth*0.12);
    [loginButton setImage:[UIImage imageNamed:@"enter_button.png"] forState:UIControlStateNormal];
    [loginButton setImage:[UIImage imageNamed:@"enter_button_click.png"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:loginButton];
    
}

- (IBAction)onClickLoginButton:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                             bundle: nil];
    
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
