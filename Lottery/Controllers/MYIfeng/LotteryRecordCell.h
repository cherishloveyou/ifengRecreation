//
//  LotteryRecordCell.h
//  Lottery
//
//  Created by August on 15/7/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryRecord.h"

@interface LotteryRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *LotteryName;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightBottomLabel;

-(void)fillWithRecord:(LotteryRecord *)record;

@end
