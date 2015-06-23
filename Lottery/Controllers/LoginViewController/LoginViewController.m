//
//  LoginViewController.m
//  Lottery
//
//  Created by 刘继洋 on 15/6/14.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomDropDownView.h"
#import "UIAlertView+DisMiss.h"
#import "HTTPClient+User.h"
#define USERINFOARRAY @"userInfomationArray"
#define useInfoArray [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:USERINFOARRAY]]
#define USERINFODIC @"userInformationDictionary"
#define uerdictionary [[NSUserDefaults standardUserDefaults] dictionaryForKey:USERINFODIC]

@interface LoginViewController ()<UITextFieldDelegate>
/**
 *  下拉列表
 */
@property (nonatomic,strong) CustomDropDownView *dropView;

@end

@implementation LoginViewController



/**
 *  便利构造器（单例模式）
 */
+ (instancetype)defaultLoginViewController{
    static LoginViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        sharedAccountManagerInstance = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    });
    return sharedAccountManagerInstance;
}

- (CustomDropDownView *)dropView{
    
    NSArray *array = useInfoArray;
    
    if (!_dropView) {
        _dropView = [[CustomDropDownView alloc] initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.bounds), 200) andDataArray:array];
        
        __weak typeof(self) weakself = self;
        
        _dropView.selectedData = ^(NSDictionary *selectedData){
            
            weakself.userNameField.text = [selectedData allKeys][0];
            
            weakself.passwordField.text = [selectedData allValues][0];
            
            weakself.dropDownButton.selected = NO;
        };
    }
    return _dropView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    NSDictionary *adiction = [useInfoArray firstObject];
    self.userNameField.text = [adiction allKeys][0];
    
    self.passwordField.text = [adiction allValues][0];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.userNameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    
    [self.dropView dismiss];
    
    self.dropDownButton.selected = NO;
}

#pragma mark -- <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    
    [textField resignFirstResponder];
    
    return YES;
}

/**
 *  下拉按钮点击
 *
 *  @param sender 
 */
- (IBAction)dropDownButtonPressed:(UIButton*)sender {
    
    [self.userNameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    
    if (sender.selected) {
        
        sender.selected = NO;
        [self.dropView dismiss];
        
    }else{
        [self.tableView addSubview:self.dropView];
        sender.selected = YES;
    }
    
}
/**
 *  登录按钮点击
 *
 *  @param sender
 */
- (IBAction)loginButtonPressed:(id)sender {
    if (!self.userNameField.text.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
        [alertView showOntime:2];
        return;
    }
    if (!self.passwordField.text.length) {
        
        [self.passwordField becomeFirstResponder];
        return;
    }
    [self loginWithUserName:self.userNameField.text passWord:self.passwordField.text];
    
}
/**
 *  登录方法
 *
 *  @param userName 用户名
 *  @param passWord 密码
 */
- (void)loginWithUserName:(NSString*)userName
                 passWord:(NSString*)passWord{
    
    NSDictionary *paramaters = @{@"uname":userName,@"pwd":passWord};
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
 [HTTPClient userHandleWithAction:UserHandlerActionLoginValidate paramaters:paramaters success:^(id task, id response) {
     
     if ([response isKindOfClass:[NSDictionary class]]) {
       NSInteger  code = [[response objectForKey:@"code"] integerValue];
         
         switch (code) {
             case 0:
                 [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                 [self saveUserInfo];
                 
                 self.userInfoDictionary = [NSDictionary dictionaryWithDictionary:response];
                 [[NSUserDefaults standardUserDefaults] setObject:self.userInfoDictionary forKey:USERINFODIC];
                 if (!self.navigationController) {
                     [self dismissViewControllerAnimated:YES completion:nil];
                 }else{
                     [self.navigationController popViewControllerAnimated:YES];
                 }
                 
                 break;
             case -2:
                 [SVProgressHUD showSuccessWithStatus:@"账号不存在"];
                 [self.userNameField becomeFirstResponder];
                 
                 break;
             case -3:
                 [SVProgressHUD showSuccessWithStatus:@"密码错误"];
                 [self.passwordField becomeFirstResponder];
                 break;
             case -4:
                 [SVProgressHUD showSuccessWithStatus:@"该账号被禁用,换一个试试!"];
                 
                 break;

             default:
                 break;
         }
     }
     
     
 } failed:^(id task, NSError *error) {
     
     [SVProgressHUD showErrorWithStatus:error.localizedDescription];
     
 }];
    
}
/**
 *  保存用户名密码
 */
- (void)saveUserInfo{
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:useInfoArray];
    
    if (array) {
        
        for (int i = 0 ;i< array.count;i++) {
            
            NSMutableDictionary *userdic = [NSMutableDictionary dictionaryWithDictionary:array[i]];
            
            if ([[[userdic allKeys] lastObject] isEqualToString:self.userNameField.text]) {
                [userdic setObject:self.passwordField.text forKey:self.userNameField.text];
                [array replaceObjectAtIndex:i withObject:userdic];
            }else{
                NSDictionary *userinfo = @{self.userNameField.text:self.passwordField.text};
                
                [array addObject:userinfo];
            }
        }
    } else{
        NSDictionary *userinfo = @{self.userNameField.text:self.passwordField.text};
        
        [array addObject:userinfo];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:USERINFOARRAY];
}


@end
