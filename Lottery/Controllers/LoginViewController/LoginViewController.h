//
//  LoginViewController.h
//  Lottery
//
//  Created by 刘继洋 on 15/6/14.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UITableViewController
/**
 *  用户头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
/**
 *  用户名输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
/**
 *  密码输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
/**
 *  登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
/**
 *  下拉按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *dropDownButton;

@end