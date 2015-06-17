//
//  LoginViewController.m
//  Lottery
//
//  Created by 刘继洋 on 15/6/14.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomDropDownView.h"

@interface LoginViewController ()<UITextFieldDelegate>
/**
 *  下拉列表
 */
@property (nonatomic,strong) CustomDropDownView *dropView;

@end

@implementation LoginViewController


- (CustomDropDownView *)dropView{
    
    NSArray *array = @[@{@"jkdjfal":@"1243"},@{@"uiyiyad":@"kjdfjksd"},@{@"lujia":@"834787"}];
    
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
        
        return;
    }
    if (!self.passwordField.text.length) {
        
        return;
    }
    
}


@end
