//
//  LotteryRecord.h
//  Lottery
//
//  Created by August on 15/7/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LotteryType) {
    LotteryTypeChongQingSS,
    LotteryTypeTianJinSS,
    LotteryTypeChongQing115
};

static NSString *const LotteryTypeDes[] = {
    [LotteryTypeChongQingSS] = @"重庆时时彩",
    [LotteryTypeTianJinSS] = @"天津时时彩",
    [LotteryTypeChongQing115] = @"重庆115"
};

typedef NS_ENUM(NSUInteger, LotteryOrderState) {
    LotteryOrderStateWinning = 2,
    LotteryOrderStateNotWinning = 3,
    LotteryOrderStateUnknow,
};

@interface LotteryRecord : NSObject

@property (nonatomic, strong) NSNumber *bonusSumMoney;
@property (nonatomic, copy) NSString *encryptId;
@property (nonatomic, assign) LotteryOrderState orderState;
@property (nonatomic, copy) NSString *orderDes;
@property (nonatomic, strong) NSNumber *termNumber;
@property (nonatomic, strong) NSNumber *totalMoney;

- (instancetype)initWithInfo:(NSDictionary *)info;
+ (NSArray *)recordWithInfos:(NSArray *)infos;

@end
