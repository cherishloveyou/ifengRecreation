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
#import <MJRefresh.h>
#import "BYLotteryHallCell.h"

@implementation ChannelViewController


#pragma lifecycle methods

-(void)viewDidLoad
{
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDataFromNetWorkin];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.autoChangeAlpha = YES;
    
    // 设置header
    self.tableView.header = header;
    [self.tableView.header beginRefreshing];
    
    
    [self baseConfigs];
}


- (void)getDataFromNetWorkin{
    
    [SVProgressHUD show];
    __weak typeof(self) weakself = self;
    [self.dataSourceArray removeAllObjects];
    
    [HTTPClient userHandleWithAction:22 paramaters:nil success:^(id task, id response) {
        
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        
        NSInteger code = [[response objectForKey:@"code"] integerValue];
        
        switch (code) {
            case 0:
                [weakself.dataSourceArray addObjectsFromArray:[response objectForKey:@"games"]];
                [weakself.tableView reloadData];
                [SVProgressHUD showSuccessWithStatus:nil];
                break;
            case -100:{
//               LoginViewController *logInVc = [LoginViewController showFromController:self];
//                
//                [SVProgressHUD showErrorWithStatus:@"您当前登录已过期请重新登录！"];
//                logInVc.block = ^(BOOL success){
//                    [weakself getDataFromNetWorkin];
//                };
            }
                break;
                
            default:
                break;
        }
        
    } failed:^(id task, NSError *error) {
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BYLotteryHallCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BYLotteryHallCell"];
    
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BYLotteryHallCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BYLotteryHallCell"];
    if (indexPath.row < self.dataSourceArray.count) {
        [cell loadDataWithDataDictionary:self.dataSourceArray[indexPath.row]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = self.dataSourceArray[indexPath.row];
    BuyingViewController *buyingViewControlelr = [[BuyingViewController alloc] initWithNibName:@"BuyingViewController" bundle:nil];
    buyingViewControlelr.hidesBottomBarWhenPushed = YES;
    buyingViewControlelr.title = info[@"_gameName"];
    
    [self.navigationController pushViewController:buyingViewControlelr animated:YES];
}


@end
