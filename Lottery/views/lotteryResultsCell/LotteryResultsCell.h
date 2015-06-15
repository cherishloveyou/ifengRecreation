//
//  LotteryResultsCell.h
//  Lottery
//
//  Created by 刘继洋 on 15/6/15.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotteryResultsCell : UITableViewCell

/**
 *  彩票名字
 */
@property (weak, nonatomic) IBOutlet UILabel *lotteryName;
/**
 *  最近开奖日期
 */
@property (weak, nonatomic) IBOutlet UILabel *firstDateLabel;
/**
 *  上一期开奖日期
 */
@property (weak, nonatomic) IBOutlet UILabel *secondDateLabel;
/**
 *  最近第二期开奖时间
 */
@property (weak, nonatomic) IBOutlet UILabel *thirdDateLabel;

@end
