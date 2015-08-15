//
//  ChooseRechargeTypeViewController.h
//  Lottery
//
//  Created by 刘继洋 on 15/8/15.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  选择后回调block
 *
 *  @param rechargeType 充值类型
 *  @param typeName     类型名称
 */
typedef void(^ChooseRechargeTypeBlock)(NSInteger rechargeType,NSString *typeName);

@interface ChooseRechargeTypeViewController : UITableViewController

/**
 *  选择彩票种类
 */
@property (copy) ChooseRechargeTypeBlock chooseRechargeType;

@end
