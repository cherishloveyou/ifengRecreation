//
//  RecordPageViewController.m
//  Lottery
//
//  Created by August on 15/7/6.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "RecordPageViewController.h"
#import <Masonry.h>
#import "Colours.h"
#import "HMSegmentedControl.h"
#import "RecordViewController.h"
#import "DropButton.h"

@interface RecordPageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) DropButton *topLeftButton;
@property (nonatomic,strong) HMSegmentedControl *topSegmentView;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation RecordPageViewController

#pragma mark - life cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
    [self addSubViewControllers];
}

#pragma mark - private methods

-(void)setUp
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.topLeftButton = [[DropButton alloc] initWithTitles:@[@"投注纪录",@"追号纪录"]];
    __weak typeof(self) wself = self;
    [self.topLeftButton setValueChangedBlock:^(NSUInteger index) {
        [wself.controllers enumerateObjectsUsingBlock:^(RecordViewController *controller, NSUInteger idx, BOOL *stop) {
            controller.betType = index+1;
            [controller getLotteryRecords];
        }];
    }];
    [self.view addSubview:self.topLeftButton];
    
    self.topSegmentView = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"未开奖",@"已中奖",@"未中奖"]];
    self.topSegmentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.topSegmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topSegmentView.selectedTitleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                                        NSForegroundColorAttributeName:[UIColor black25PercentColor]};
    self.topSegmentView.selectionIndicatorHeight = 2;
    self.topSegmentView.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                                NSForegroundColorAttributeName:[UIColor grayColor]};
    [self.topSegmentView setIndexChangeBlock:^(NSInteger index) {
        [wself.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.bounds)*index, 0) animated:YES];
    }];
    [self.view addSubview:self.topSegmentView];
    
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    [self.view bringSubviewToFront:self.topLeftButton];
    
    [self.topLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(@0);
        make.height.mas_equalTo(44);
    }];
    
    [self.topSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLeftButton);
        make.left.equalTo(self.topLeftButton.mas_right);
        make.height.equalTo(@44);
        make.right.equalTo(@0);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(@0);
        make.top.equalTo(self.topSegmentView.mas_bottom);
    }];
}

-(void)addSubViewControllers
{
    RecordViewController *all = [[RecordViewController alloc] initWithNibName:@"RecordViewController" bundle:nil];
    [all willMoveToParentViewController:self];
    [self addChildViewController:all];
    [self.scrollView addSubview:all.view];
    [all didMoveToParentViewController:self];
    
    RecordViewController *notOpen = [[RecordViewController alloc] initWithNibName:@"RecordViewController" bundle:nil];
    
    notOpen.winningType = LotteryWinningTypeNotOpen;
    [notOpen willMoveToParentViewController:self];
    [self addChildViewController:notOpen];
    [self.scrollView addSubview:notOpen.view];
    [notOpen didMoveToParentViewController:self];

    RecordViewController *hasGot = [[RecordViewController alloc] initWithNibName:@"RecordViewController" bundle:nil];
    hasGot.winningType = LotteryWinningTypeWinning;
    [hasGot willMoveToParentViewController:self];
    [self addChildViewController:hasGot];
    [self.scrollView addSubview:hasGot.view];
    [hasGot didMoveToParentViewController:self];

    RecordViewController *notGot = [[RecordViewController alloc] initWithNibName:@"RecordViewController" bundle:nil];
    
    notGot.winningType = LotteryWinningTypeNotWinning;
    [notGot willMoveToParentViewController:self];
    [self addChildViewController:notGot];
    [self.scrollView addSubview:notGot.view];
    [notGot didMoveToParentViewController:self];

    self.controllers = @[all,notOpen,hasGot,notGot];
    
    [all.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.top.equalTo(@0);
        make.height.equalTo(self.scrollView);
        make.width.equalTo(self.view);
    }];
    
    [notOpen.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(all.view.mas_right);
        make.top.and.bottom.equalTo(@0);
        make.height.equalTo(self.scrollView);
        make.width.equalTo(self.view);
    }];
    
    [hasGot.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(notOpen.view.mas_right);
        make.top.and.bottom.equalTo(@0);
        make.height.equalTo(self.scrollView);
        make.width.equalTo(self.view);
    }];
    
    [notGot.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hasGot.view.mas_right);
        make.top.and.bottom.and.right.equalTo(@0);
        make.height.equalTo(self.scrollView);
        make.width.equalTo(self.view);
    }];

}

#pragma mark - event methods

#pragma mark - UIScrollViewDelegate methods

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = self.scrollView.contentOffset;
    [self.topSegmentView setSelectedSegmentIndex:offset.x/CGRectGetWidth(self.view.bounds) animated:YES];
}

#pragma mark - memory methods

-(void)dealloc
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
