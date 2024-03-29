//
//  TrendViewController.m
//  Lottery
//
//  Created by August on 15/5/24.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "TrendViewController.h"
#import "HTTPClient+User.h"
#import "LotteryResultsCell.h"
#import <MJRefresh.h>
#import "LotteryDetailVC.h"
#import "BuyingViewController.h"

@implementation TrendViewController

- (NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

- (void)viewDidLoad{
    
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
    [HTTPClient userHandleWithAction:21 paramaters:nil success:^(id task, id response) {
        NSInteger code = [[response objectForKey:@"code"] integerValue];
        [SVProgressHUD showSuccessWithStatus:nil];
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        switch (code) {
            case 0:{
                self.dataSourceArray = [NSMutableArray arrayWithArray:[response objectForKey:@"lotteryRatherInfos"]];
                [self.tableView reloadData];
            }
                break;
            case -100:
                
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

#pragma mark - private methods

-(void)baseConfigs
{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LotteryResultsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LotteryResultsCell"];
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LotteryResultsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LotteryResultsCell"];
    if (indexPath.row < self.dataSourceArray.count) {
        [cell loadDataWithArray:self.dataSourceArray[indexPath.row]];
    }
//    点击cell的@"立即投注"跳转至相应的购彩页面
    __weak typeof(self) weakSelf = self;
    cell.buyBlock = ^(NSString *lotteryId){
        
        BuyingViewController *buyVC = [[BuyingViewController alloc] initWithNibName:@"BuyingViewController" bundle:[NSBundle mainBundle]];
        
        if ([lotteryId isEqualToString:@"1"]) {//重庆时时彩
            
            buyVC.title = @"重庆时时彩";
            buyVC.lotteryType = LotteryTypeChongQingShiShiCai;
            buyVC.hidesBottomBarWhenPushed = YES;

            [weakSelf.navigationController pushViewController:buyVC animated:YES];
            
        }else if([lotteryId isEqualToString:@"4"]){
            
            buyVC.title = @"山东11选5";
            buyVC.lotteryType = LotteryTypeChongQingShiShiCai;
            buyVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:buyVC animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"该彩票暂时不能购买"];
        }
        
    };
    
    return cell;
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140.;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LotteryDetailVC *detailVC = [[LotteryDetailVC alloc] initWithNibName:@"LotteryDetailVC" bundle:[NSBundle mainBundle]];
    
    detailVC.dataSourceArray = self.dataSourceArray[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


@end
