//
//  ModifyPasswordViewController.m
//  Lottery
//
//  Created by August on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import <ReactiveCocoa.h>
#import "HTTPClient+User.h"

@interface ModifyPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *currentTextField;
@property (weak, nonatomic) IBOutlet UITextField *theNewTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneItem;

@end

@implementation ModifyPasswordViewController

#pragma mark - lifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

-(void)dealloc
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

-(void)setUp
{
    RAC(self.doneItem,enabled) = [RACSignal combineLatest:@[self.currentTextField.rac_textSignal,self.theNewTextField.rac_textSignal,self.confirmTextField.rac_textSignal] reduce:^(NSString *old,NSString *new, NSString *confirm){
        return @(old.length > 0 && new.length > 0 && confirm.length > 0);
    }];
}

#pragma mark -  event methdos

- (IBAction)doneItemClicked:(id)sender {
    
    if (![self.theNewTextField.text isEqualToString:self.confirmTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"您前后输入的密码不一致!"];
        [self.theNewTextField becomeFirstResponder];
        return;
    }
    
    UserHandlerAction action = UserHandlerActionModifySafePassword;
    NSDictionary *parameters = @{@"oldpwd":self.currentTextField.text,
                                 @"npwd":self.theNewTextField.text};
    
    if (self.modifyType == PasswordTypeLogin) {//修改安全码
        
        
        action = UserHandlerActionModifyLoginPassword;
        
        parameters = @{@"currentPwd":self.currentTextField.text,
                       @"newPwd":self.theNewTextField.text,@"confrimPwd":self.confirmTextField.text};
    }
    
    
    __weak typeof(self) weakself = self;
    
    
    
    [HTTPClient userHandleWithAction:action
                          paramaters:parameters
                             success:^(id task, id response) {
                                 NSInteger code = [[response valueForKey:@"code"] integerValue];
                                 [weakself showInfoWithResultCode:code];
                                 
                             } failed:^(id task, NSError *error) {
                                 
                                 
                             }];
}

- (void)showInfoWithResultCode:(NSInteger)code{
    
    
    switch (code) {
        case 0:{//成功
            [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case -1:{
            [SVProgressHUD showInfoWithStatus:@"请输入新密码"];
            [self.theNewTextField becomeFirstResponder];
        }
            break;
        case -2:{
            
            if (self.modifyType == PasswordTypeLogin) {
                [SVProgressHUD showErrorWithStatus:@"您前后输入的密码不一致!"];
                [self.theNewTextField becomeFirstResponder];
            }else{
                
            }
        }
            break;
        case -3:{
            if (self.modifyType == PasswordTypeLogin) {
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"含有非法字符!"];
                [self.theNewTextField becomeFirstResponder];
            }
        }
            break;
        case -4:{
            if (self.modifyType == PasswordTypeLogin) {
                [SVProgressHUD showErrorWithStatus:@"您输入的密码不合法!"];
                [self.theNewTextField becomeFirstResponder];
            }else{
                [SVProgressHUD showInfoWithStatus:@"数据库操作失败,请稍后再试!"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            break;
        case -5:{
            if (self.modifyType == PasswordTypeLogin) {
                
            }else{
                [SVProgressHUD showInfoWithStatus:@"原始密码和新密码一致!"];
                [self.theNewTextField becomeFirstResponder];
            }
        }
            break;
        default:
            break;
    }
    
    
}


@end
