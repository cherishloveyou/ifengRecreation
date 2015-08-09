//
//  ADDBankCardViewController.m
//  Lottery
//
//  Created by 刘继洋 on 15/8/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ADDBankCardViewController.h"
#import <SVProgressHUD.h>

@interface ADDBankCardViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UIPickerView *pickerView;
    
    UIView *pickerBackView;
}
/**
 *  银行卡类型
 */
@property (weak, nonatomic) IBOutlet UITextField *bankCardType;
/**
 *  卡号
 */
@property (weak, nonatomic) IBOutlet UITextField *cardNumber;
/**
 *  开户地址（省、市）
 */
@property (weak, nonatomic) IBOutlet UITextField *openAddress;
/**
 *  开户分行名称
 */
@property (weak, nonatomic) IBOutlet UITextField *nameOfBank;
/**
 *  户名
 */
@property (weak, nonatomic) IBOutlet UITextField *userNameOfCard;
/**
 *  安全密码
 */
@property (weak, nonatomic) IBOutlet UITextField *safePassWord;
/**
 *  picker的数据源
 */
@property (nonatomic,strong) NSMutableArray *pickerDataSource;



@end

@implementation ADDBankCardViewController


- (NSMutableArray *)pickerDataSource{
    if (!_pickerDataSource) {
        _pickerDataSource = [NSMutableArray array];
    }
    return _pickerDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  添加银行卡
 *
 *  @param sender button
 */
- (IBAction)makeSoureToAddBankCard:(id)sender {
    
    if ([self comperWithTextFeilds]) {
        
    }
}

/**
 *  对比填入内容是否正确完整
 *
 *  @return bool值
 */
- (BOOL)comperWithTextFeilds{
    
    if (self.bankCardType.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"请选择银行类型"];
        return NO;
    }
    if (self.cardNumber.text.length > 19 || self.cardNumber.text.length < 16) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的银行卡密码"];
        return NO;
    }
    if (self.openAddress.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入开户行所在地"];
        return NO;
    }
    if (self.nameOfBank.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入支行名称"];
        return NO;
    }
    if (self.userNameOfCard.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入户名"];
        return NO;
    }
    if (self.safePassWord.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入安全码"];
        return NO;
    }
    
    return YES;
}

#pragma mark -- UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    pickerBackView = [[UIView alloc] initWithFrame:self.view.bounds];
    pickerBackView.backgroundColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:0.6];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removePickerView)];
    [pickerBackView addGestureRecognizer:recognizer];
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 124, self.view.bounds.size.width, 70)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.backgroundColor = [UIColor blueColor];
    [pickerBackView addSubview:pickerView];
    [self.view addSubview:pickerBackView];
    return NO;
}


- (void)removePickerView{
    [pickerBackView removeFromSuperview];
    pickerView = nil;
    pickerBackView = nil;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.safePassWord resignFirstResponder];
}

#pragma  mark -- UIPickerViewDataSource
/**
 *  轮子个数
 *
 *  @param pickerView pickerView
 *
 *  @return 个数
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
/**
 *  行数
 *
 *  @param pickerView
 *  @param component  轮子
 *
 *  @return 行数
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerDataSource.count;
}

#pragma mark -- UIPickerViewDelegate
/**
 *  对应cell的text
 *
 *  @param pickerView
 *  @param row
 *  @param component
 *
 *  @return string
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"test";
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30.;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    self.bankCardType.text = nil;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [pickerView removeFromSuperview];
}


@end
