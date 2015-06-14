//
//  LoginViewController.m
//  Lottery
//
//  Created by 刘继洋 on 15/6/14.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source


#pragma mark - Table view delegate


#pragma mark -- <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

/**
 *  下拉按钮点击
 *
 *  @param sender 按钮对象
 */
- (IBAction)dropDownButtonPressed:(id)sender {
    
}
/**
 *  登录按钮点击
 *
 *  @param sender <#sender description#>
 */
- (IBAction)loginButtonPressed:(id)sender {
    
}


@end
