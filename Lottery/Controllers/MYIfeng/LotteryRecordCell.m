//
//  LotteryRecordCell.m
//  Lottery
//
//  Created by August on 15/7/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "LotteryRecordCell.h"
#import "Colours.h"

@implementation LotteryRecordCell

- (void)awakeFromNib {

}

-(void)fillWithRecord:(LotteryRecord *)record
{
    self.LotteryName.text = @"重庆时时彩";
    self.costLabel.text = record.totalMoney.description;
    if (record.orderState == LotteryOrderStateWinning) {
        self.statusLabel.textColor = [UIColor greenColor];
        self.rightBottomLabel.textColor = [UIColor greenColor];
        self.statusLabel.text = @"已中奖";
        self.rightBottomLabel.text = record.bonusSumMoney.description;
    }else{
        self.statusLabel.textColor = [UIColor black50PercentColor];
        self.rightBottomLabel.textColor = [UIColor black50PercentColor];
        self.statusLabel.text = nil;
        self.rightBottomLabel.text = @"未中奖";
    }
}

@end
