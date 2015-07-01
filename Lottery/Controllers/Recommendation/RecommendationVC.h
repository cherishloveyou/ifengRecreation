//
//  RecommendationVC.h
//  Lottery
//
//  Created by 刘继洋 on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RecommendDelegate <NSObject>

@optional



@end

@interface RecommendationVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *advertisementView;
/**
 *  数字间距约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint4;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightFirstConstraint;
/**
 *  时时彩名称
 */
@property (weak, nonatomic) IBOutlet UILabel *lotteryNameLabel;



/**
 *  背景scrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;
/**
 *  下拉按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *dropDownButton;
/**
 *  开奖期数
 */
@property (weak, nonatomic) IBOutlet UILabel *lotteryStage;
/**
 *  彩票种类
 */
@property (nonatomic,strong) NSArray *lotteryArray;
/**
 *  开奖数据
 */
@property (nonatomic,strong) NSArray *numbers;
/**
 *  代理
 */
@property (nonatomic,assign) id <RecommendDelegate>delegate;
/**
 *  下拉个人信息
 */
@property (weak,nonatomic) IBOutlet UIView * usetinfoView;
/**
 *  用户名
 */
@property (weak,nonatomic) IBOutlet UILabel * userName;
/**
 *  昨天中奖情况
 */
@property (weak,nonatomic) IBOutlet UILabel * yesterdayMony;
/**
 *  账户余额
 */
@property (weak, nonatomic) IBOutlet UILabel *balance;
/**
 *  存放 热门彩种的购买链接或者id
 */
@property (strong, nonatomic)  NSMutableArray *hotLotteryIds;
/**
 *  用户信息View的上约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoViewConstraint;

#define sCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define uSERINFOVIEWHEIGHT sCREENWIDTH*0.63


@end
