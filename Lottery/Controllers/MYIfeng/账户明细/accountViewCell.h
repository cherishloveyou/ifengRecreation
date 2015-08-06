//
//  accountViewCell.h
//  Lottery
//
//  Created by 刘继洋 on 15/8/6.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface accountViewCell : UITableViewCell
/**
 *  明细名称
 */
@property (weak,nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  返回时间
 */
@property (weak,nonatomic) IBOutlet UILabel *timeLablel;
/**
 *  钱数
 */
@property (weak,nonatomic) IBOutlet UILabel *moneyLabel;

/**
 *  添加数据
 */
- (void)loadDataWithDataDic:(NSDictionary*)dataDic;

@end
