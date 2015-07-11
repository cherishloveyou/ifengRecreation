//
//  LotteryDetailVC.h
//  Lottery
//
//  Created by 刘继洋 on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotteryDetailVC : UIViewController

/**
 *  数据源
 */
@property (strong, nonatomic)NSArray *dataSourceArray;

/**
 *  彩票id（类型）
 */
@property (nonatomic,copy) NSString *lotteryId;

@end
