//
//  RecordViewController.m
//  Lottery
//
//  Created by August on 15/7/6.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "RecordViewController.h"
#import <MJRefresh.h>
#import "HTTPClient+User.h"
#import "LotteryRecord.h"
#import "LotteryRecordCell.h"

@interface RecordViewController ()

@property (nonatomic, strong) NSMutableArray *records;

@end

@implementation RecordViewController

NSString *const reuseIdentifier = @"RecordCell";

#pragma mark - life cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

-(void)setUp
{
    self.records = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.records removeAllObjects];
        [weakSelf getLotteryRecords];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.autoChangeAlpha = YES;
    // 设置header
    self.tableView.header = header;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LotteryRecordCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView.header beginRefreshing];
}

#pragma mark - public methods

-(void)getLotteryRecords
{
    [HTTPClient userHandleWithAction:UserHandlerActionLooteryRecord
                          paramaters:@{@"Orderstate" :[NSNumber numberWithInteger:self.winningType],
                                       @"betType":[NSNumber numberWithInteger:self.betType]} success:^(id task, id response) {
                                           
                                           NSArray *recordInfos = response[@"betRecordInfos"];
                                           NSArray *records = [LotteryRecord recordWithInfos:recordInfos];
                                           [self.records removeAllObjects];
                                           [self.records addObjectsFromArray:records];
                                           [self.tableView reloadData];
                                           [SVProgressHUD showSuccessWithStatus:nil];
                                           [self.tableView.header endRefreshing];
                                           
                                       } failed:^(id task, NSError *error) {
                                           [self.tableView.header endRefreshing];
                                           [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                       }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LotteryRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    LotteryRecord *record = self.records[indexPath.row];
    [cell fillWithRecord:record];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
