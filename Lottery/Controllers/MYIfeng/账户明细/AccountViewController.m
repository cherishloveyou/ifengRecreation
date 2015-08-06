//
//  AccountViewController.m
//  Lottery
//
//  Created by 刘继洋 on 15/7/22.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "AccountViewController.h"
#import "HMSegmentedControl.h"
#import "Colours.h"
#import <Masonry.h>
#import "HTTPClient+User.h"
#import "accountViewCell.h"
#import <MJRefresh.h>

@interface AccountViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    BOOL allHadRefreshed;
    
    BOOL bonusHadRefreshed;
    
    BOOL rechargeHadRefreshed;
    
    BOOL depositHadRefreshed;
}
/**
 *  顶部按钮容器
 */
@property (nonatomic,weak) IBOutlet HMSegmentedControl *topSegmentView;
/**
 *  所有数据类型table
 */
@property (nonatomic,weak) IBOutlet UITableView *allDataTableView;
/**
 *  奖金返点table
 */
@property (nonatomic,weak) IBOutlet UITableView *bonusTableView;
/**
 *  充值table
 */
@property (nonatomic,weak) IBOutlet UITableView *rechargeTableView;
/**
 *  取现table
 */
@property (nonatomic,weak) IBOutlet UITableView *depositTableView;

/**
 *  滑动scrollview
 */
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;

/**
 *  所有类型
 */
@property (nonatomic,strong) NSMutableArray *allTypeArray;
/**
 *  奖金派送
 */
@property (nonatomic,strong) NSMutableArray *bonusDataArray;
/**
 *  充值
 */
@property (nonatomic,strong) NSMutableArray *rechargeArray;
/**
 *  提现
 */
@property (nonatomic,strong) NSMutableArray *depositArray;

@end

@implementation AccountViewController
/**
 *  所有类型
 *
 *  @return 实例
 */
- (NSMutableArray *)allTypeArray{
    if (!_allTypeArray) {
        _allTypeArray = [NSMutableArray array];
    }
    return _allTypeArray;
}
/**
 *  奖金返点
 *
 *  @return 实例
 */
- (NSMutableArray *)bonusDataArray{
    if (!_bonusDataArray) {
        _bonusDataArray = [NSMutableArray array];
        
    }
    return _bonusDataArray;
}
/**
 *  充值
 *
 *  @return 实例
 */
- (NSMutableArray *)rechargeArray{
    if (!_rechargeArray) {
        _rechargeArray = [NSMutableArray array];
    }
    return  _rechargeArray;
}
/**
 *  提现
 *
 *  @return 实例
 */
- (NSMutableArray *)depositArray{
    if (!_depositArray ) {
        _depositArray = [NSMutableArray array];
    }
    return _depositArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUp];
    [self tableviewAddHeader];
    [self.allDataTableView registerNib:[UINib nibWithNibName:@"accountViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"accountViewCell"];
}
/**
 *  初始化userinterface
 */
- (void)setUp{
    __weak typeof(self) wself = self;
    
//    self.topSegmentView = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"所有类型",@"奖金派送",@"充值",@"提现"]];
    self.topSegmentView.sectionTitles = @[@"所有类型",@"奖金派送",@"充值",@"提现"];
    
    self.topSegmentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.topSegmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topSegmentView.selectedTitleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                                        NSForegroundColorAttributeName:[UIColor black25PercentColor]};
    self.topSegmentView.selectionIndicatorHeight = 2;
    self.topSegmentView.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                                NSForegroundColorAttributeName:[UIColor grayColor]};
    [self.topSegmentView setIndexChangeBlock:^(NSInteger index) {
        [wself.scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(wself.view.bounds)*index, 0, CGRectGetWidth(wself.view.bounds), CGRectGetHeight(wself.view.bounds)) animated:YES];
        switch (index) {
            case 1://奖金
                if (!bonusHadRefreshed) {
                    [wself.bonusTableView.header beginRefreshing];
                    bonusHadRefreshed = YES;
                }
                break;
            case 2://充值
                if (!rechargeHadRefreshed) {
                    [wself.rechargeTableView.header beginRefreshing];
                    rechargeHadRefreshed = YES;
                }
                break;
            case 3://提现
                if (!depositHadRefreshed) {
                    [wself.depositTableView.header beginRefreshing];
                    depositHadRefreshed = YES;
                }
                break;
            default:
                break;
        }

    }];
}

/**
 *  为tableView添加下拉刷新控件
 */
- (void)tableviewAddHeader{
    __weak typeof(self) weakSelf = self;
//    所有类型数据tableheader
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDataFromNetWorkin];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.autoChangeAlpha = YES;
    
    // 设置header
    self.allDataTableView.header = header;
    /**
     *  让所有数据开始刷新
     */
    [self.allDataTableView.header beginRefreshing];
    
//    奖金派送header
    
    MJRefreshNormalHeader *bonusHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getbonusDataFromNetWorkin];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    bonusHeader.autoChangeAlpha = YES;
    
    // 设置header
    self.bonusTableView.header = bonusHeader;
    
//    充值类型tableheader
    
    MJRefreshNormalHeader *rechargeHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getrechargeDataFromNetWorkin];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    rechargeHeader.autoChangeAlpha = YES;
    
    // 设置header
    self.rechargeTableView.header = rechargeHeader;
    
//    提现类型tableheader
    
    MJRefreshNormalHeader *depositHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDepositDataFromNetWorkin];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    depositHeader.autoChangeAlpha = YES;
    
    // 设置header
    self.depositTableView.header = depositHeader;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *  获取所有类型数据
 */
- (void)getDataFromNetWorkin{
        __weak typeof(self) weakself = self;
    [self.allTypeArray removeAllObjects];
    
    NSDictionary *parameters = @{@"page":@"1",@"pageSize":@"30",@"pageParam":@"fuddetail"};
    
    [HTTPClient userHandleWithAction:23 paramaters:parameters success:^(id task, id response){
        if ([weakself.allDataTableView.header isRefreshing]) {
            [weakself.allDataTableView.header endRefreshing];
        }
        NSInteger code = [[response valueForKey:@"result"] integerValue];
        NSInteger totalCount = [[response valueForKey:@"totalCount"] integerValue];
        if (!code && totalCount) {//成功有数据
            
            [weakself.allTypeArray addObjectsFromArray:[response valueForKey:@"records"]];
            [weakself.allDataTableView reloadData];
        }else{//失败
            [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
        }
        
        
    } failed:^(id task, NSError *error) {
        if ([weakself.allDataTableView.header isRefreshing]) {
            [weakself.allDataTableView.header endRefreshing];
        }
        [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
    }];
}
/**
 *  获取奖金派送数据
 */
- (void)getbonusDataFromNetWorkin{
   
    __weak typeof(self) weakself = self;
    [self.allTypeArray removeAllObjects];
    
    NSDictionary *parameters = @{@"page":@"1",@"pageSize":@"30",@"pageParam":@"rewards"};
    
    [HTTPClient userHandleWithAction:23 paramaters:parameters success:^(id task, id response){
        if ([weakself.bonusTableView.header isRefreshing]) {
            [weakself.bonusTableView.header endRefreshing];
        }
        
        NSInteger code = [[response valueForKey:@"result"] integerValue];
        NSInteger totalCount = [[response valueForKey:@"totalCount"] integerValue];
        if (!code && totalCount) {//成功有数据
            
            [weakself.bonusDataArray addObjectsFromArray:[response valueForKey:@"records"]];
            [weakself.bonusTableView reloadData];
        }else{//失败
            [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
        }
        
    } failed:^(id task, NSError *error) {
        if ([weakself.bonusTableView.header isRefreshing]) {
            [weakself.bonusTableView.header endRefreshing];
        }
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

/**
 *  获取充值数据
 */
- (void)getrechargeDataFromNetWorkin{
    
    __weak typeof(self) weakself = self;
    [self.allTypeArray removeAllObjects];
    
    NSDictionary *parameters = @{@"page":@"1",@"pageSize":@"30",@"pageParam":@"recharge"};
    
    [HTTPClient userHandleWithAction:23 paramaters:parameters success:^(id task, id response){
        if ([weakself.rechargeTableView.header isRefreshing]) {
            [weakself.rechargeTableView.header endRefreshing];
        }
        
        NSInteger code = [[response valueForKey:@"result"] integerValue];
        NSInteger totalCount = [[response valueForKey:@"totalCount"] integerValue];
        if (!code && totalCount) {//成功有数据
            
            [weakself.rechargeArray addObjectsFromArray:[response valueForKey:@"records"]];
            [weakself.rechargeTableView reloadData];
        }else{//失败
            
            [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
            [weakself tableViewAddNoDataInfoMation:self.rechargeTableView];
        }
        
    } failed:^(id task, NSError *error) {
        if ([weakself.rechargeTableView.header isRefreshing]) {
            [weakself.rechargeTableView.header endRefreshing];
        }
        
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}
/**
 *  获取提现数据
 */
- (void)getDepositDataFromNetWorkin{
    __weak typeof(self) weakself = self;
    [self.allTypeArray removeAllObjects];
    
    NSDictionary *parameters = @{@"page":@"1",@"pageSize":@"30",@"pageParam":@"withdraw"};
    
    [HTTPClient userHandleWithAction:23 paramaters:parameters success:^(id task, id response){
        if ([weakself.depositTableView.header isRefreshing]) {
            [weakself.depositTableView.header endRefreshing];
        }
        
        NSInteger code = [[response valueForKey:@"result"] integerValue];
        NSInteger totalCount = [[response valueForKey:@"totalCount"] integerValue];
        if (!code && totalCount) {//成功有数据
            
            [weakself.depositArray addObjectsFromArray:[response valueForKey:@"records"]];
            [weakself.depositTableView reloadData];
        }else{//失败
            
            [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
        }
        
    } failed:^(id task, NSError *error) {
        if ([weakself.depositTableView.header isRefreshing]) {
            [weakself.depositTableView.header endRefreshing];
        }
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

#pragma mark - UIScrollViewDelegate methods

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = self.scrollView.contentOffset;
    [self.topSegmentView setSelectedSegmentIndex:offset.x/CGRectGetWidth(self.view.bounds) animated:YES];
    switch (self.topSegmentView.selectedSegmentIndex) {
        case 1://奖金
            if (!bonusHadRefreshed) {
                [self.bonusTableView.header beginRefreshing];
                bonusHadRefreshed = YES;
            }
            break;
        case 2://充值
            if (!rechargeHadRefreshed) {
                [self.rechargeTableView.header beginRefreshing];
                rechargeHadRefreshed = YES;
            }
            break;
        case 3://提现
            if (!depositHadRefreshed) {
                [self.depositTableView.header beginRefreshing];
                depositHadRefreshed = YES;
            }
            break;
        default:
            break;
    }
    
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
/**
 *  tablecell
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    accountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountViewCell"];
    NSDictionary *dataDic;
    if (tableView == self.allDataTableView) {
        
        dataDic =  self.allTypeArray[indexPath.row];
        
    }else if (tableView == self.bonusTableView){
        
        dataDic = self.bonusDataArray[indexPath.row];
        
    }else if(tableView == self.rechargeTableView){
        
        dataDic = self.rechargeArray[indexPath.row];
        
    }else dataDic = self.depositArray[indexPath.row];
    
    [cell loadDataWithDataDic:dataDic];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.;
}
/**
 *  table中数据条数
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.allDataTableView) {

        return self.allTypeArray.count;
        
    }else if (tableView == self.bonusTableView){

        return self.bonusDataArray.count;
    }else if(tableView == self.rechargeTableView){

        return self.rechargeArray.count;
        
    }else{

        return self.depositArray.count;
    }
    
}
/**
 *  当没有获取到数据显示暂无数据图片
 *
 *  @param tableView 
 */
- (void)tableViewAddNoDataInfoMation:(UITableView*)tableView{
    UIView *nodataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    nodataView.center = tableView.center;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 58, 65)];
    imageView.image = [UIImage imageNamed:@"note_gray"];
    [nodataView addSubview:imageView];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), 100, 30)];
    infoLabel.text = @"暂无数据";
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = [UIColor grayColor];
    [nodataView addSubview:infoLabel];
    
    [tableView addSubview:nodataView];
}


@end
