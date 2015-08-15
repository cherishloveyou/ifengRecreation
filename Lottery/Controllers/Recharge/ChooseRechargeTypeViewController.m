//
//  ChooseRechargeTypeViewController.m
//  Lottery
//
//  Created by 刘继洋 on 15/8/15.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ChooseRechargeTypeViewController.h"

@interface ChooseRechargeTypeViewController ()

@end

@implementation ChooseRechargeTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择充值方式";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"工商银行充值";
        cell.imageView.image = [UIImage imageNamed:@"bank_gs"];
    }else if(indexPath.row == 1){
        
        cell.textLabel.text = @"财付通充值";
        cell.imageView.image = [UIImage imageNamed:@""];
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"支付宝充值";
        cell.imageView.image = [UIImage imageNamed:@""];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChooseRechargeTypeBlock chooseBlock = self.chooseRechargeType;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (chooseBlock) {
        chooseBlock(indexPath.row + 1,cell.textLabel.text);
    }
}

@end
