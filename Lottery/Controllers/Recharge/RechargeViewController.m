//
//  RechargeViewController.m
//  Lottery
//
//  Created by August on 15/7/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "RechargeViewController.h"
#import "HTTPClient+User.h"
#import <MJRefresh.h>
#import "ChooseRechargeTypeViewController.h"

@interface RechargeViewController ()<UITextFieldDelegate>
/**
 *  充值方式
 */
@property (nonatomic,weak) IBOutlet UITextField *rechargeTypeTextField;
/**
 *  充值金额
 */
@property (nonatomic,weak) IBOutlet UITextField *rechargeMoneyTextField;
/**
 *  确定充值按钮
 */
@property (nonatomic,weak) IBOutlet UIView *tableFooterView;
/**
 *  充值类型
 */
@property (nonatomic,assign) NSInteger rechargeType;

@end

@implementation RechargeViewController

#pragma mark - life cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    self.tableView.tableFooterView = self.tableFooterView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)makeSureToRecharge:(id)sender{
    if (self.rechargeTypeTextField.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择您的充值方式"];
        return;
    }
    if (self.rechargeMoneyTextField.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"充值金额不低于100元"];
        [self.rechargeMoneyTextField becomeFirstResponder];
        return;
    }
    if ([self.rechargeMoneyTextField.text integerValue] < 100) {
        [SVProgressHUD showInfoWithStatus:@"最低充值金额为100元"];
        [self.rechargeMoneyTextField becomeFirstResponder];
        self.rechargeMoneyTextField.text = nil;
        return;
    }
    
    NSNumber *type = [NSNumber numberWithInteger:self.rechargeType];
    NSNumber *money = [NSNumber numberWithInteger:[self.rechargeMoneyTextField.text integerValue]];
    
    NSDictionary *parameters = @{@"type":type,@"ammount":money};
    
    __weak typeof(self) weakself = self;
    
    [SVProgressHUD show];
    [HTTPClient userHandleWithAction:20 paramaters:parameters success:^(id task, id response) {
        
        NSInteger code = [[response valueForKey:@"code"] integerValue];
        [weakself showInfoWithResultCode:code];
        
    } failed:^(id task, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络连接错误,请稍后再试!"];
    }];
    
}

#pragma mark - private methods

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    ChooseRechargeTypeViewController *chooseVC = [[ChooseRechargeTypeViewController alloc] init];
    __weak typeof(self)weakself = self;
    chooseVC.chooseRechargeType = ^(NSInteger type ,NSString *typeName){
        weakself.rechargeType = type;
        weakself.rechargeTypeTextField.text = typeName;
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:chooseVC animated:YES];
    
    return NO;
}

- (void)showInfoWithResultCode:(NSInteger)code{
    
    
    switch (code) {
        case 0:{//成功
            [SVProgressHUD showSuccessWithStatus:@"创建订单成功"];
            
        }
        case -3:{
            [SVProgressHUD showErrorWithStatus:@"当前已经存在之前没有完成充值的订单!"];
        }
            break;
        default:
            [SVProgressHUD showErrorWithStatus:nil];
            break;
    }
    
}

@end
