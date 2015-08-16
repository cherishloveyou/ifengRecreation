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

@interface RechargeViewController ()
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

@property (nonatomic,weak) IBOutlet UIImageView *selectedImageFirst;

@property (nonatomic,weak) IBOutlet UIImageView *selectedImageSecend;

@property (nonatomic,weak) IBOutlet UIImageView *selectedImageThird;
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
    if (self.rechargeType == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择您的充值方式"];
        return;
    }
    if (self.rechargeMoneyTextField.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"充值金额不低于10元"];
        [self.rechargeMoneyTextField becomeFirstResponder];
        return;
    }
    if ([self.rechargeMoneyTextField.text integerValue] < 10) {
        [SVProgressHUD showInfoWithStatus:@"最低充值金额为10元"];
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
    
    self.selectedImageFirst.hidden = YES;
    self.selectedImageSecend.hidden = YES;
    self.selectedImageThird.hidden = YES;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.selectedImageFirst.hidden = NO;
            self.rechargeType = 1;
        }else if (indexPath.row == 1){
            self.selectedImageSecend.hidden = NO;
            self.rechargeType = 2;
        }else if (indexPath.row == 2){
            self.selectedImageThird.hidden = NO;
            self.rechargeType = 3;
        }
    }
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
