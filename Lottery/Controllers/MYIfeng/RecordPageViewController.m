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

@interface RecordPageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *topLeftButton;
@property (nonatomic,strong) HMSegmentedControl *topSegmentView;
@property (nonatomic, strong, readwrite) NSArray *controllers;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation RecordPageViewController

#pragma mark - life cycle methods

-(instancetype)initWithControllers:(NSArray *)controllers
{
    self = [super init];
    if (self) {
        self.controllers = controllers;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

#pragma mark - private methods

-(void)setUp
{
    
    self.topLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.topLeftButton setTitle:@"投注纪录" forState:UIControlStateNormal];
    [self.topLeftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.topLeftButton];
    
    self.topSegmentView = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部",@"未开奖",@"已中奖",@"未中奖"]];
    self.topSegmentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.topSegmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topSegmentView.selectionIndicatorHeight = 2;
    self.topSegmentView.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                                NSForegroundColorAttributeName:[UIColor grayColor]};
    __weak typeof(self) wself = self;
    [self.topSegmentView setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"test");
    }];
    [self.view addSubview:self.topSegmentView];
    
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.scrollView];
    
    
    [self.topLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(@0);
        make.height.mas_equalTo(44);
    }];
    
    [self.topSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLeftButton);
        make.left.equalTo(self.topLeftButton.mas_right);
        make.height.equalTo(self.topLeftButton);
        make.right.equalTo(@0);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(@0);
        make.top.equalTo(self.topSegmentView.mas_bottom);
    }];
    
}

#pragma mark - event methods


#pragma mark - memory methods

-(void)dealloc
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
