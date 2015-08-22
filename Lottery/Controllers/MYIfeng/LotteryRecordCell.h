//
//  LotteryRecordCell.h
//  Lottery
//
//  Created by August on 15/7/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryRecord.h"

@interface LotteryRecordCell : UITableViewCell
/**
 *  中奖金额
 */
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
/**
 *  彩票名称
 */
@property (weak, nonatomic) IBOutlet UILabel *LotteryName;
/**
 *  购买金额
 */
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
/**
 *  彩票状态
 */
@property (weak, nonatomic) IBOutlet UILabel *rightBottomLabel;
/**
 *  月份
 */
@property (weak, nonatomic) IBOutlet UILabel *monthLable;
/**
 *  日期
 */
@property (weak, nonatomic) IBOutlet UILabel *dateLable;

-(void)fillWithRecord:(LotteryRecord *)record;

@end
