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

@interface AccountViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
/**
 *  顶部按钮容器
 */
@property (nonatomic,weak) IBOutlet HMSegmentedControl *topSegmentView;

//@property (nonatomic,strong) HMSegmentedControl *topSegmentView;
/**
 *  滑动scrollview
 */
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUp];
}

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
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate methods

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = self.scrollView.contentOffset;
    [self.topSegmentView setSelectedSegmentIndex:offset.x/CGRectGetWidth(self.view.bounds) animated:YES];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

@end
