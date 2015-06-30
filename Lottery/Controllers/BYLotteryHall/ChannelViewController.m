//
//  ChannelViewController.m
//  Lottery
//
//  Created by August on 15/5/24.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ChannelViewController.h"
#import "HTTPClient+User.h"
#import "BuyingViewController.h"
#import "HTTPClient+User.h"
#import "LoginViewController.h"

@implementation ChannelViewController


#pragma lifecycle methods

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self getDataFromNetWorkin];
    [self baseConfigs];
}


- (void)getDataFromNetWorkin{
    
    [SVProgressHUD show];
    [HTTPClient userHandleWithAction:22 paramaters:nil success:^(id task, id response) {
        
        NSInteger code = [[response objectForKey:@"code"] integerValue];
        
        switch (code) {
            case 0:
                [self.dataSourceArray addObjectsFromArray:[response objectForKey:@"games"]];
                
                [SVProgressHUD showSuccessWithStatus:nil];
                break;
            case -100:
                [LoginViewController showFromController:self];
                [SVProgressHUD showErrorWithStatus:@"您当前登录已过期请重新登录！"];
                break;
                
            default:
                break;
        }
        
    } failed:^(id task, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

- (NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}


#pragma mark - private methods

-(void)baseConfigs
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"test";
    return cell;
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        BuyingViewController *buyingViewControlelr = [[BuyingViewController alloc] initWithNibName:@"BuyingViewController" bundle:nil];
        buyingViewControlelr.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:buyingViewControlelr animated:YES];
}


@end
