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
    
    [self.announcementTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.insideLetterTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"lcell"];
    [self getDataFrom];
}
/**
 *  添加下拉和上拉控件
 */
- (void)setUpTableHeaderViewAndFooterView{
    
    __weak typeof(self) weakSelf = self;
    // 设置公告的下拉刷新
    MJRefreshNormalHeader *announheader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.announcementArray removeAllObjects];
//        [weakSelf getLotteryRecords];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    announheader.autoChangeAlpha = YES;
    // 设置header
    self.announcementTable.header = announheader;
    //设置 站内信 下拉刷新
    MJRefreshNormalHeader *insidHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.insidelLerrerArray removeAllObjects];
        //        [weakSelf getLotteryRecords];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    announheader.autoChangeAlpha = YES;
    // 设置header
    self.insideLetterTable.header = insidHeader;
    
    //添加上拉控件
    
}


- (void)getDataFrom{
    [HTTPClient userHandleWithAction:24 paramaters:@{@"page": @"1",@"pageSize":@"20"} success:^(id task, id response) {
        NSLog(@"%@",response);
    } failed:^(id task, NSError *error) {
        
    }];
}

- (void)getAnnouncementData{
    
}

- (void)getInsidelLerrerData{
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (tableView == self.insideLetterTable) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"lcell"];
    }
    cell.textLabel.text = @"test";
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
