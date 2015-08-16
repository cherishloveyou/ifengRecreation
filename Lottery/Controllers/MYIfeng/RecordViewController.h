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
    LotteryWinningTypeWinning = 1, //已中奖
    LotteryWinningTypeNotWinning = 2, //未中奖
    LotteryWinningTypeNotOpen = 3,//未开奖
};

@interface RecordViewController : UITableViewController

@property (nonatomic, assign) LotteryBetType betType;

- (void)getLotteryRecords;

@end
