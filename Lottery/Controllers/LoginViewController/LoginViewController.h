//
//  LoginViewController.h
//  Lottery
//
//  Created by 刘继洋 on 15/6/14.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^logInBlock)(BOOL success);

typedef void (^ImageUrlsBlock)(NSArray* imagesUrls);

@interface LoginViewController : UITableViewController

#define USERINFOARRAY @"userInfomationArray"
#define useInfoArray [[NSUserDefaults standardUserDefaults] arrayForKey:USERINFOARRAY]

#define USERINFODIC @"userInformationDictionary"
#define uerdictionary [[NSUserDefaults standardUserDefaults] dictionaryForKey:USERINFODIC]

#define currentFlag @"currentFlag"

#define CURRENTLOGINFLAG [[NSUserDefaults standardUserDefaults] stringForKey:currentFlag]


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
/**
 *  用户信息
 */
@property (nonatomic,strong) NSDictionary *userInfoDictionary;
/**
 *  广告栏图片数组
 */
@property (nonatomic,copy) NSArray *imageUrlsArray;
/**
 *  登录标识 用于判定 是否重复登录
 */
@property (nonatomic,strong) NSString *loginFlag;
/**
 *  登录成功
 */
@property (copy) logInBlock block;
/**
 *  登录成功 返回的广告栏图片链接
 */
@property (copy) ImageUrlsBlock imageBlock;


/**
 *  便利构造器（单例模式）
 */
+ (instancetype)defaultLoginViewController;
/**
 *  登录界面show
 *
 *  @param controller 父controller
 */
+ (instancetype)showFromController:(UIViewController*)controller;

@end
