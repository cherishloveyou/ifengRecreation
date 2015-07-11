//
//  LotteryDetailVC.m
//  Lottery
//
//  Created by 刘继洋 on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "LotteryDetailVC.h"
#import "LotteryDetailCell.h"

@interface LotteryDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation LotteryDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSDictionary *adic = [self.dataSourceArray firstObject];
    
    self.title = [adic objectForKey:@"LotteryName"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LotteryDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LotteryDetailCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  立即购买彩票
 *
 *  @param sender 
 */
- (IBAction)goToBuyLottery:(UIButton*)sender{
#warning 跳转至对应购彩页面
    NSDictionary *adic = [self.dataSourceArray firstObject];
    
    self.lotteryId = [NSString stringWithFormat:@"%@",[adic objectForKey:@"LotteryType"]];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LotteryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LotteryDetailCell"];
    if (indexPath.row == 0) {
        cell.cellStyle = LotteryDetailCellStyleImageNumbers;
    }else{
        cell.cellStyle = LotteryDetailCellStyleLabelNumbers;
    }
    [cell loadDataWithDictionary:self.dataSourceArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

@end
