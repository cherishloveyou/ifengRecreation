//
//  NumbersBasketCell.h
//  Lottery
//
//  Created by 刘继洋 on 15/8/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NumbersBasketDeleteBlock)(NSIndexPath *indexpath);

/**
 *  彩票类型
 */
typedef NS_ENUM(NSInteger, lotteryType){
    
    LotteryTypeChongQingShiShiCai = 0,//重庆时时彩
    LotteryTypeShandongShiYiXuanWu,//山东十一选5
};

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

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


@property (nonatomic,copy) NSIndexPath *indexPath;

@property (nonatomic,assign) BOOL isEditing;

/**
 *  彩票种类
 */
@property (assign,nonatomic) lotteryType lotteryType;
/**
 *  编辑状态下点击删除按钮回调
 */
@property (copy) NumbersBasketDeleteBlock deleteBlock;

- (void)setUpWithNumebrdic:(NSDictionary *)numersdic;

@end
