//
//  LotteryResultsCell.h
//  Lottery
//
//  Created by 刘继洋 on 15/6/15.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  点击cell的立即投注
 *
 *  @param lotteryId 对应的lottery的id
 */
typedef void(^GoToBuyLotteryBlock)(NSString *lotteryId);

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
/**
 *  最新开奖号码数组（images）
 */
@property (strong, nonatomic) NSArray *firstNumbers;
/**
 *  上一期开奖号码（labels）
 */
@property (strong, nonatomic) NSArray *secondNumbers;
/**
 *  上上期的开奖号码（labels）
 */
@property (strong, nonatomic) NSArray *thirdNumbers;
/**
 *  彩票id（类型）
 */
@property (nonatomic,copy) NSString *lotteryId;
/**
 *  点击@“立即投注”回调
 */
@property (copy) GoToBuyLotteryBlock buyBlock;

/**
 *  装载数据
 *
 *  @param dataArray 数据源
 */
- (void)loadDataWithArray:(NSArray*)dataArray;

@end
