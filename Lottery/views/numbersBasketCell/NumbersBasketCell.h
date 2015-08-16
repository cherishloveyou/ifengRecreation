//
//  NumbersBasketCell.h
//  Lottery
//
//  Created by 刘继洋 on 15/8/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumbersBasketCell : UITableViewCell
/**
 *  所选号码
 */
@property (weak, nonatomic) IBOutlet UILabel *numbersLabel;
/**
 *  玩法名称
 */
@property (weak, nonatomic) IBOutlet UILabel *playPlanName;
/**
 *  计算公式
 */
@property (weak, nonatomic) IBOutlet UILabel *calculateFormulaLabel;

@end
