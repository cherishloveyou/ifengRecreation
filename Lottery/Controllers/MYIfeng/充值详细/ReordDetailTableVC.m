//
//  ReordDetailTableVC.m
//  Lottery
//
//  Created by 刘继洋 on 15/9/5.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ReordDetailTableVC.h"

@interface ReordDetailTableVC ()
/**
 *  收款银行
 */
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
/**
 *  收款账号
 */
@property (weak, nonatomic) IBOutlet UILabel *bankNumLabel;
/**
 *  户名
 */
@property (weak, nonatomic) IBOutlet UILabel *bankUserNameLabel;
/**
 *  附言
 */
@property (weak, nonatomic) IBOutlet UILabel *messagesLabel;
/**
 *  流水号
 */
@property (weak, nonatomic) IBOutlet UILabel *serialIdLabel;
/**
 *  剩余时间
 */
@property (weak, nonatomic) IBOutlet UILabel *surplusSeconedsLabel;
/**
 *  充值金额
 */
@property (weak, nonatomic) IBOutlet UILabel *ammountLabel;
/**
 *  footer
 */
@property (weak, nonatomic) IBOutlet UIView *footerView;

@property  (nonatomic,assign) NSInteger secondsCount;

@end

@implementation ReordDetailTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = self.footerView;
    [self setUp];
}


- (void)setUp{
    if (self.dataDic) {
        self.bankNameLabel.text = [self.dataDic valueForKey:@"bankName"];
        self.bankNumLabel.text = [self.dataDic valueForKey:@"bankNum"];
        
        self.bankUserNameLabel.text = [self.dataDic valueForKey:@"bankUserName"];
        self.messagesLabel.text = [self.dataDic valueForKey:@"messages"];
        self.serialIdLabel.text = [self.dataDic valueForKey:@"serialId"];
        self.ammountLabel.text = [NSString stringWithFormat:@"%@",[self.dataDic valueForKey:@"ammount"]];
    }
    self.secondsCount = 7200;
    [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(startTiming) userInfo:nil repeats:YES];
}

- (void)startTiming{
    self.secondsCount -- ;
    if (self.secondsCount == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    NSInteger hour = self.secondsCount/3600;
    NSInteger minute = (self.secondsCount%3600)/60;
    NSInteger seconds = self.secondsCount%60;
    
    self.surplusSeconedsLabel.text = [NSString stringWithFormat:@"%li小时%li分%li秒",hour,minute,seconds];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  充值完成
 *
 *  @param sender 
 */
- (IBAction)RecordHavedone:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
