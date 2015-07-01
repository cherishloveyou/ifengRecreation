//
//  BYLotteryHallCell.h
//  Lottery
//
//  Created by 刘继洋 on 15/6/14.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYLotteryHallCell : UITableViewCell
/**
 *  彩票头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *lotteryHeaderImage;
/**
 *  彩票名称
 */
@property (weak, nonatomic) IBOutlet UILabel *lotteryNameLabel;
/**
 *  彩票介绍
 */
@property (weak, nonatomic) IBOutlet UILabel *lotterySnippetLabel;
/**
 *  彩票类型（自主彩票、新彩票）
 */
@property (weak, nonatomic) IBOutlet UIImageView *lotteryTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *lotteryTypeLabel;

/**
 *  装载数据
 *
 *  @param dataDic 数据源
 */
- (void)loadDataWithDataDictionary:(NSDictionary *)dataDic;



@end
