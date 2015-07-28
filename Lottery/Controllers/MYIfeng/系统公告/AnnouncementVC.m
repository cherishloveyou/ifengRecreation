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
#import "AnnouncementDetailVC.h"
#import "InsidelDetailVC.h"
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
//    [self getDataFrom];

}
/**
 *  添加下拉和上拉控件
 */
- (void)setUpTableHeaderViewAndFooterView{
    
    __weak typeof(self) weakSelf = self;
    // 设置公告的下拉刷新
    MJRefreshNormalHeader *announheader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.announcementArray removeAllObjects];
        [weakSelf getAnnouncementData];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    announheader.autoChangeAlpha = YES;
    // 设置header
    self.announcementTable.header = announheader;
    //设置 站内信 下拉刷新
    MJRefreshNormalHeader *insidHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.insidelLerrerArray removeAllObjects];
        [weakSelf getInsidelLerrerData];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    announheader.autoChangeAlpha = YES;
    // 设置header
    self.insideLetterTable.header = insidHeader;
    [self.announcementTable.header beginRefreshing];
    [self.insideLetterTable.header beginRefreshing];
    
//    //添加上拉控件
//    
//    MJRefreshBackNormalFooter *annoFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf getAnnouncementData];
//        
//        
//    }];
//    self.announcementTable.footer = annoFooter;
//    self.announcementTable.footer.autoChangeAlpha = YES;
//    
//    MJRefreshBackNormalFooter *insideFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf getInsidelLerrerData];
//        
//    }];
//    self.insideLetterTable.footer = insideFooter;
//    self.insideLetterTable.footer.autoChangeAlpha = YES;
    
    
}

//
//- (void)getDataFrom{
//    [SVProgressHUD show];
//    __weak typeof(self) wself = self;
//    NSString *pageindex = [NSString stringWithFormat:@"%ld",self.annoPageIndex];
//    [HTTPClient userHandleWithAction:24 paramaters:@{@"page": @"1",@"pageSize":@"20"} success:^(id task, id response) {
//        NSLog(@"%@",response);
//        [SVProgressHUD showSuccessWithStatus:nil];
//    } failed:^(id task, NSError *error) {
//        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
//    }];
//}
/**
 *  请求公告
 */
- (void)getAnnouncementData{
    [SVProgressHUD show];
    __weak typeof(self) wself = self;
    [HTTPClient userHandleWithAction:24 paramaters:@{@"page": @"1",@"pageSize":@"20"} success:^(id task, id response) {
        [wself.announcementTable.header endRefreshing];
        NSLog(@"%@",response);
        [SVProgressHUD showSuccessWithStatus:nil];
        NSArray *array = [response objectForKey:@"notices"];
        [wself.announcementArray addObjectsFromArray:array];
        [wself.announcementTable reloadData];
        
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
        [wself.insideLetterTable.header endRefreshing];
        NSArray *daarray = response;
        
        if (daarray.count) {
            [wself.insidelLerrerArray addObjectsFromArray:response];
            [wself.insideLetterTable reloadData];
        }
        NSLog(@"%@",response);
    } failed:^(id task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
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
    
    if (tableView == self.announcementTable) {
        return self.announcementArray.count;
    }else return self.insidelLerrerArray.count;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (tableView == self.announcementTable) {
        NSDictionary *data = self.announcementArray[indexPath.row];
        cell.textLabel.text = [data objectForKey:@"title"];
        cell.detailTextLabel.text = [self timeTransformWithTime:[data objectForKey:@"addTime"]];
    }else{
        NSDictionary *data = self.insidelLerrerArray[indexPath.row];
        cell.textLabel.text = [data objectForKey:@"title"];
        cell.detailTextLabel.text = [self timeTransformWithTime:[data objectForKey:@"addDate"]];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.;
}
/**
 *  点击cell推送至 相关controller
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.announcementTable) {
        AnnouncementDetailVC *VC = [[AnnouncementDetailVC alloc] initWithNibName:@"AnnouncementDetailVC" bundle:[NSBundle mainBundle]];
        VC.dataDic = self.announcementArray[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        InsidelDetailVC *inVC = [[InsidelDetailVC alloc] initWithNibName:@"InsidelDetailVC" bundle:[NSBundle mainBundle]];
        inVC.dataDic = self.insidelLerrerArray[indexPath.row];
        [self.navigationController pushViewController:inVC animated:YES];
        
    }
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.backScrollView) {
        self.segment.selectedSegmentIndex = scrollView.contentOffset.x/(CGRectGetWidth(self.view.bounds) - 30);
    }
    
}
/**
 *  时间转换
 *
 *  @param timeString 时间戳
 *
 *  @return 转换完成的标准时间
 */
- (NSString*)timeTransformWithTime:(NSString*)timeString{
    NSString *newTime = [timeString substringWithRange:NSMakeRange(6, 10)];
    double lastactivityInterval = [newTime  doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH：mm"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:(lastactivityInterval)];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}



@end
