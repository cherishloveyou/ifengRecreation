//
//  LotteryDetailCell.h
//  Lottery
//
//  Created by 刘继洋 on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LotteryDetailCellStyle) {
    LotteryDetailCellStyleImageNumbers = 0,//以图片形式显示号码
    LotteryDetailCellStyleLabelNumbers,//Label显示数字
};

@interface LotteryDetailCell : UITableViewCell

/**
 *  彩票id（类型）
 */
@property (nonatomic,copy) NSString *lotteryId;
/**
 *  cell类型
 */
@property (assign) LotteryDetailCellStyle cellStyle;

- (void)loadDataWithDictionary:(NSDictionary*)datadic;

@end
