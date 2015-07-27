//
//  AnnouncementVC.m
//  Lottery
//
//  Created by 刘继洋 on 15/7/13.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "AnnouncementVC.h"
#import <MJRefresh.h>
#import "HTTPClient+User.h"
#import <SVProgressHUD.h>

@interface AnnouncementVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
/**
 *  头部选择器
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

/**
 *  列表容器
 */
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

/**
 *  公告
 */
@property (weak, nonatomic) IBOutlet UITableView *announcementTable;
/**
 *  站内信
 */
@property (weak, nonatomic) IBOutlet UITableView *insideLetterTable;
/**
 *  公告数据源
 */
@property (nonatomic, strong) NSMutableArray *announcementArray;
/**
 *  站内信数据源
 */
@property (nonatomic, strong) NSMutableArray *insidelLerrerArray;
/**
 *  公告第几页
 */
@property (nonatomic, assign) NSInteger annoPageIndex;
/**
 *  站内信第几页
 */
@property (nonatomic, assign) NSInteger insidePageIndex;

@end

@implementation AnnouncementVC


- (NSMutableArray *)announcementArray{
    if (!_announcementArray) {
        _announcementArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _announcementArray;
}

- (NSMutableArray *)insidelLerrerArray{
    if (!_insidelLerrerArray) {
        _insidelLerrerArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _insidelLerrerArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpTableHeaderViewAndFooterView];
    [self getDataFrom];

}
/**
 *  添加下拉和上拉控件
 */
- (void)setUpTableHeaderViewAndFooterView{
    
    __weak typeof(self) weakSelf = self;
    // 设置公告的下拉刷新
    MJRefreshNormalHeader *announheader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.annoPageIndex = 1;
        [weakSelf.announcementArray removeAllObjects];
        [weakSelf getAnnouncementData];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    announheader.autoChangeAlpha = YES;
    // 设置header
    self.announcementTable.header = announheader;
    //设置 站内信 下拉刷新
    MJRefreshNormalHeader *insidHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.insidePageIndex = 1;
        [weakSelf.insidelLerrerArray removeAllObjects];
        [weakSelf getInsidelLerrerData];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    announheader.autoChangeAlpha = YES;
    // 设置header
    self.insideLetterTable.header = insidHeader;
    
    //添加上拉控件
    
    MJRefreshAutoFooter *annoFooter = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf getAnnouncementData];
    }];
    self.announcementTable.footer = annoFooter;
    
    MJRefreshAutoFooter *insideFooter = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf getInsidelLerrerData];
    }];
    self.insideLetterTable.footer = insideFooter;
    
    
}


- (void)getDataFrom{
    [SVProgressHUD show];
    __weak typeof(self) wself = self;
    [HTTPClient userHandleWithAction:25 paramaters:@{@"page": @"1",@"pageSize":@"20"} success:^(id task, id response) {
        NSLog(@"%@",response);
        [SVProgressHUD showSuccessWithStatus:nil];
    } failed:^(id task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}
/**
 *  请求公告
 */
- (void)getAnnouncementData{
    [SVProgressHUD show];
    __weak typeof(self) wself = self;
    [HTTPClient userHandleWithAction:24 paramaters:@{@"page": @"1",@"pageSize":@"20"} success:^(id task, id response) {
        [SVProgressHUD showSuccessWithStatus:nil];
    } failed:^(id task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
    self.annoPageIndex++;
}
/**
 *  请求站内信
 */
- (void)getInsidelLerrerData{
    __weak typeof(self) wself = self;
    [HTTPClient userHandleWithAction:25 paramaters:@{@"page": @"1",@"pageSize":@"20"} success:^(id task, id response) {
        [wself.announcementTable.header endRefreshing];
    } failed:^(id task, NSError *error) {
        
    }];
    self.insidePageIndex++;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/**
 *  点击segment
 *
 *  @param sender segmentcontrol
 */
- (IBAction)selectedControl:(UISegmentedControl *)sender {
    
    NSInteger index = sender.selectedSegmentIndex;
    if (index == 0) {
        [self.backScrollView scrollRectToVisible:self.view.frame animated:YES];
    }else{
        [self.backScrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width  , 200, self.view.frame.size.width, 200) animated:YES];
    }
}


#pragma mark -- <UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.;
}

#pragma mark -- UIScrollViewDelegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.segment.selectedSegmentIndex = scrollView.contentOffset.x/CGRectGetWidth(self.view.bounds);
}



@end
