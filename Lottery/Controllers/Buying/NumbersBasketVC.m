//
//  NumbersBasketVC.m
//  Lottery
//
//  Created by 刘继洋 on 15/8/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "NumbersBasketVC.h"
#import "NumbersBasketCell.h"

@interface NumbersBasketVC ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  包含清空按钮的tablefooter
 */
@property (strong, nonatomic) IBOutlet UIView *tableFooterView;
/**
 *
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  机选一注
 */
@property (weak, nonatomic) IBOutlet UIButton *jiXuanYizhuButton;
/**
 *  机选五注
 */
@property (weak, nonatomic) IBOutlet UIButton *jiXuanWuZhuButton;
/**
 *  继续投注
 */
@property (weak, nonatomic) IBOutlet UIButton *jiXuTouZhuButton;
/**
 *  底部投注按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *touZhuButton;
/**
 *  追加倍数
 */
@property (weak, nonatomic) IBOutlet UITextField *touZhuBeiShuTextField;
/**
 *  追加期数
 */
@property (weak, nonatomic) IBOutlet UITextField *zhuiJiaQiShuTextField;
/**
 *  购买所需金额
 */
@property (weak, nonatomic) IBOutlet UILabel *buyMoneyLabel;
/**
 *  账户余额
 */
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
/**
 *  清空所有所选按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *cleanButton;



@end

@implementation NumbersBasketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUserInterFace];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  初始化用户界面
 */
- (void)setUpUserInterFace{
    self.tableView.tableFooterView = self.tableFooterView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NumbersBasketCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NumbersBasketCell"];
}

#pragma mark - buttonActions
/**
 *  机选一注
 *
 *  @param sender
 */
- (IBAction)randomOne:(id)sender {
}
/**
 *  机选5注
 *
 *  @param sender
 */
- (IBAction)randomFive:(id)sender {
}
/**
 *  继续投注
 *
 *  @param sender
 */
- (IBAction)goOnToBuy:(id)sender {
}
/**
 *  投注
 *
 *  @param sender
 */
- (IBAction)toBuyCommitToConnect:(id)sender {
}

/**
 *  清空所有
 *
 *  @param sender
 */
- (IBAction)cleanAllSelected:(id)sender {
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NumbersBasketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NumbersBasketCell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.;
}

@end
