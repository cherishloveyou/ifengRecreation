//
//  LotteryRecord.m
//  Lottery
//
//  Created by August on 15/7/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "LotteryRecord.h"

@implementation LotteryRecord

-(instancetype)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        self.bonusSumMoney = info[@"_bonusSumMoney"];
        self.encryptId = info[@"_encryptId"];
        self.orderState = [info[@"_orderState"] integerValue];
        self.orderDes = info[@"_orderStateStr"];
        self.termNumber = info[@"_termNum"];
        self.totalMoney = info[@"_totalMoney"];
    }
    return self;
}

+(NSArray *)recordWithInfos:(NSArray *)infos
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *info in  infos) {
        LotteryRecord *record = [[LotteryRecord alloc] initWithInfo:info];
        [array addObject:record];
    }
    return array.copy;
}

@end
