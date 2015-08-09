//
//  BankCardManageViewController.m
//  Lottery
//
//  Created by August on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "BankCardManageViewController.h"
#import "HTTPClient+User.h"

@interface BankCardManageViewController ()
/**
 *  银行卡数据源
 */
@property (nonatomic, strong) NSMutableArray *bankCards;
/**
 *  添加银行卡按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *addCardButton;
/**
 *  地步提示Label
 */
@property (weak, nonatomic) IBOutlet UILabel *footerTitleLabel;
/**
 *  footerView
 */
@property (weak, nonatomic) IBOutlet UIView *tableFooterView;

@end

@implementation BankCardManageViewController

- (NSMutableArray *)bankCards{
    if (!_bankCards) {
        _bankCards = [NSMutableArray array];
    }
    return _bankCards;
}

#pragma mark - lifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = self.tableFooterView;
    
    [HTTPClient userHandleWithAction:27 paramaters:nil success:^(id task, id response) {
        NSLog(@"%@",response);
        NSInteger code = [[response valueForKey:@"code"] integerValue];
        if (!code) {
            [self.bankCards addObjectsFromArray:[response objectForKey:@"userBanks"]];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取银行卡信息失败！"];
        }
        
    } failed:^(id task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"获取银行卡信息失败！"];
    }];
    self.footerTitleLabel.text = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

#pragma mark -  event methdos

- (IBAction)addCardButtonClicked:(id)sender {
    
}


#pragma mark - UITableViewDataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bankCards.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankCard" forIndexPath:indexPath];
    NSDictionary *dataDic = self.bankCards[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[dataDic valueForKey:@"bankName"]];
    NSString *cardNum = [NSString stringWithFormat:@"%@",[dataDic valueForKey:@"cardNum"]];
    NSRange range = NSMakeRange((cardNum.length - 4), 4);
    NSString *substring = [cardNum substringWithRange:range];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"******%@",substring];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.;
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
