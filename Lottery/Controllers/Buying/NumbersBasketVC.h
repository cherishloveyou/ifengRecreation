//
//  NumbersBasketVC.h
//  Lottery
//
//  Created by 刘继洋 on 15/8/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  彩票类型
 */
typedef NS_ENUM(NSInteger, LotteryType){
    
    LotteryTypeChongQingShiShiCai = 0,//重庆时时彩
    LotteryTypeShandongShiYiXuanWu,//山东十一选5
};

@interface NumbersBasketVC : UIViewController
/**
 *  包装成字典传入
 *  字典结构：所选号码value: (nsstring)123456,4,6,7,9  key:玩法名（五星直选）
 *
 */
@property (nonatomic,strong) NSMutableArray *dataSourceArray;
/**
 *  单注奖金
 */
@property (nonatomic,assign) CGFloat amount;
/**
 *  彩票种类
 */
@property (assign,nonatomic) LotteryType lotteryType;

@end
