//
//  BankCardManageViewController.h
//  Lottery
//
//  Created by August on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  选择银行卡block
 *
 *  @param bankCardInfo   银行卡信息
 */
typedef void(^BankCardSelectedBlock)(NSDictionary *bankCardInfo);

@interface BankCardManageViewController : UITableViewController

/**
 *  是否是添加银行卡
 */
@property (nonatomic,assign) BOOL isNotAddBankCard;
/**
 *  选择银行卡 回调
 */
@property (copy) BankCardSelectedBlock selectedBankcard;

@end
