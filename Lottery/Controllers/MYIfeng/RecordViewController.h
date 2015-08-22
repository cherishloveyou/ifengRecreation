//
//  RecordViewController.h
//  Lottery
//
//  Created by August on 15/7/6.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPClient+User.h"


typedef NS_ENUM(NSUInteger, LotteryWinningType) {
    LotteryWinningTypeNotOpen = 1,//未开奖
    LotteryWinningTypeWinning = 2, //已中奖
    LotteryWinningTypeNotWinning = 3, //未中奖
};

@interface RecordViewController : UITableViewController

@property (nonatomic, assign) LotteryBetType betType;

@property (nonatomic, assign) LotteryWinningType winningType;


- (void)getLotteryRecords;

@end
