//
//  WithDrawViewController.m
//  Lottery
//
//  Created by August on 15/7/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "WithDrawViewController.h"
#import "BankCardManageViewController.h"
#import "HTTPClient+User.h"


NSString *const ToBankCardManagerController = @"ToBankCardManagerController";

@interface WithDrawViewController ()<UITextFieldDelegate>
/**
 *  银行卡号
 */
@property (nonatomic,weak) IBOutlet UITextField *bankCardTextField;
/**
 *  提现金额
 */
@property (nonatomic,weak) IBOutlet UITextField *moneyTextField;
/**
 *  安全密码
 */
@property (nonatomic,weak) IBOutlet UITextField *safePasswordTextFild;
/**
 *  银行卡id
 */
@property (nonatomic,strong) NSString *cardId;

@end

@implementation WithDrawViewController

#pragma mark - life cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

- (void)setUp {
    self.title = @"提现";
}

/**
 *  取现
 *
 *  @param sender button
 */
- (IBAction)cashTheMoney:(id)sender{
    if ([self comper]) {
        NSDictionary *parameters = @{};
        
        __weak typeof(self) weakself = self;
        [SVProgressHUD showWithStatus:@"正在提交申请"];
        [HTTPClient userHandleWithAction:6 paramaters:parameters success:^(id task, id response) {
            
            NSInteger code = [[response valueForKey:@"code"] integerValue];
            [weakself showInfoWithResultCode:code];
            
        } failed:^(id task, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络连接失败，请稍后再试！"];
        }];
    }
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma  mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    BankCardManageViewController *bankCard = [self.storyboard instantiateViewControllerWithIdentifier:@"BankCardManageViewController"];
    
    bankCard.isNotAddBankCard = YES;
    /**
     *  选择银行卡block
     *
     *  @param cardNumber 卡信息
     */
    __weak typeof(self) weakself = self;
    
    bankCard.selectedBankcard = ^(NSDictionary *bankCardInfo){
        NSString *cardNum = [NSString stringWithFormat:@"%@",[bankCardInfo valueForKey:@"cardNum"]];
        NSRange range = NSMakeRange((cardNum.length - 4), 4);
        
        NSString *substring = [cardNum substringWithRange:range];
        
        NSString *userName = [bankCardInfo valueForKey:@"cardName"];
        
        weakself.bankCardTextField.text = [NSString stringWithFormat:@"卡号:******%@ 户名:%@",substring,userName];
        weakself.cardId = [bankCardInfo valueForKey:@"id"];
        [weakself.navigationController popViewControllerAnimated:YES];
       
    };
    
    [self.navigationController pushViewController:bankCard animated:YES];
    
    return NO;
}



- (BOOL)comper{
    if (self.bankCardTextField.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:@"请选择您的银行卡"];
        return NO;
    }
    if ([self.moneyTextField.text integerValue] < 100) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的取款金额"];
        [self.moneyTextField becomeFirstResponder];
        return NO;
    }
    if (self.safePasswordTextFild.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的安全密码"];
        [self.safePasswordTextFild becomeFirstResponder];
        return NO;
    }
    return YES;
}

- (void)showInfoWithResultCode:(NSInteger)code{
    
    
    switch (code) {
        case 0:{//成功
            [SVProgressHUD showSuccessWithStatus:@"您的提现申请已成功受理"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        case -1:{
            [SVProgressHUD showErrorWithStatus:@"安全密码错误请重新输入!"];
            [self.safePasswordTextFild becomeFirstResponder];
        }
            break;
        case -3:{
            [SVProgressHUD showErrorWithStatus:@"安全密码错误请重新输入!"];
            [self.safePasswordTextFild becomeFirstResponder];
        }
            break;
        case -4:{
            [SVProgressHUD showInfoWithStatus:@"您的余额不足!"];
            
        }
            break;
        case -7:
            [SVProgressHUD showInfoWithStatus:@"银行卡绑定一个小时之内不能申请取款!"];
            break;
        case -8:
            [SVProgressHUD showInfoWithStatus:@"早上2点到10点不能申请提现!"];
            break;
        default:
            [SVProgressHUD showErrorWithStatus:nil];
            break;
    }
    
    
}



@end
