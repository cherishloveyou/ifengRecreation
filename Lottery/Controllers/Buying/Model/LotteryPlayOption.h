//
//  LotteryPlayOption.h
//  Lottery
//
//  Created by August on 15/8/15.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LotteryPlayType) {
    LotteryPlayType5zhi,
    LotteryPlayType5zu120,
    LotteryPlayType5zu60,
    LotteryPlayType5zu30,
    LotteryPlayType5zu20,
    LotteryPlayType5zu10,
    LotteryPlayType5zu5,
    LotteryPlayType4zhi,
    LotteryPlayType4zu24,
    LotteryPlayType4zu12,
    LotteryPlayTypeQ3zhi,
    LotteryPlayTypeQ3zu3,
    LotteryPlayTypeQ3zu6,
    LotteryPlayTypeQ3zuHe,
    LotteryPlayTypeQ3zuBD,
    LotteryPlayTypeH3zhiF,
    LotteryPlayTypeH3zhiK,
    LotteryPlayTypeH3zu3,
    LotteryPlayTypeH3zu6,
    LotteryPlayTypeH3zuHe,
    LotteryPlayTypeH3zuBD,
    LotteryPlayType2zhiH2,
    LotteryPlayType2zhiH2He,
    LotteryPlayType2zhiH2K,
    LotteryPlayType2zhiQ2,
    LotteryPlayType2zhiQ2K,
    LotteryPlayType2zuH2,
    LotteryPlayType2zuQ2,
    LotteryPlayTypeDWD,
    LotteryPlayType3BDWH31,
    LotteryPlayType3BDWH32,
    LotteryPlayType3BDWQ31,
    LotteryPlayType3BDWQ32,
    LotteryPlayType4BDW2,
    LotteryPlayType5BDW2,
    LotteryPlayType5BDW3,
    LotteryPlayTypeT1,
    LotteryPlayTypeTH,
    LotteryPlayTypeT3,
    LotteryPlayTypeT4,
};

static NSString *const lotteryPlayTypeString[] = {
    [LotteryPlayType5zhi] = @"五星直选",
    [LotteryPlayType5zu120] = @"组选120",
    [LotteryPlayType5zu60] = @"组选60",
    [LotteryPlayType5zu30] = @"组选30",
    [LotteryPlayType5zu20] = @"组选20",
    [LotteryPlayType5zu10] = @"组选10",
    [LotteryPlayType5zu5] = @"组选5",
    [LotteryPlayType4zhi] = @"四星直选",
    [LotteryPlayType4zu24] = @"四星组选24",
    [LotteryPlayType4zu12] = @"四星组选12",
    [LotteryPlayTypeQ3zhi] = @"前三直选",
    [LotteryPlayTypeQ3zu3] = @"前三组三",
    [LotteryPlayTypeQ3zu6] = @"前三组六",
    [LotteryPlayTypeQ3zuHe] = @"前三组选_和值",
    [LotteryPlayTypeQ3zuBD] = @"前三组选_包胆",
    [LotteryPlayTypeH3zhiF] = @"后三直选",
    [LotteryPlayTypeH3zhiK] = @"后三直选跨度",
    [LotteryPlayTypeH3zu3] = @"后三组三",
    [LotteryPlayTypeH3zu6] = @"后三组六",
    [LotteryPlayTypeH3zuHe] = @"后三组选_和值",
    [LotteryPlayTypeH3zuBD] = @"后三组选_包胆",
    [LotteryPlayType2zhiH2] = @"后二直选",
    [LotteryPlayType2zhiH2He] = @"后二直选和值",
    [LotteryPlayType2zhiH2K] = @"后二直选跨度",
    [LotteryPlayType2zhiQ2] = @"前二直选",
    [LotteryPlayType2zhiQ2K] = @"前二跨度",
    [LotteryPlayType2zuH2] = @"后二组选",
    [LotteryPlayType2zuQ2] = @"前二组选",
    [LotteryPlayTypeDWD] = @"定位胆",
    [LotteryPlayType3BDWH31] = @"后三一码不定位",
    [LotteryPlayType3BDWH32] = @"后三二码不定位",
    [LotteryPlayType3BDWQ31] = @"前三一码不定位",
    [LotteryPlayType3BDWQ32] = @"前三二码不定位",
    [LotteryPlayType4BDW2] = @"四星二码不定位",
    [LotteryPlayType5BDW2] = @"五星二码不定位",
    [LotteryPlayType5BDW3] = @"五星三码不定位",
    [LotteryPlayTypeT1] = @"一帆风顺",
    [LotteryPlayTypeTH] = @"好事成双",
    [LotteryPlayTypeT3] = @"三星报喜",
    [LotteryPlayTypeT4] = @"四季发财",
};

@interface LotteryPlayOption : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) LotteryPlayType type;

- (instancetype)initWithType:(LotteryPlayType)type title:(NSString *)title;

+ (instancetype)optionWithType:(LotteryPlayType)type;

@end
