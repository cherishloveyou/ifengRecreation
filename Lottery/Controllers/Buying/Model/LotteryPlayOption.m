//
//  LotteryPlayOption.m
//  Lottery
//
//  Created by August on 15/8/15.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "LotteryPlayOption.h"

@implementation LotteryPlayOption

- (instancetype)initWithType:(LotteryPlayType)type title:(NSString *)title {
    self = [super init];
    if (self) {
        self.type = type;
        self.title = [title copy];
    }
    return self;
}

+ (instancetype)optionWithType:(LotteryPlayType)type {
    LotteryPlayOption *option = nil;
    switch (type) {
        case LotteryPlayType5zhi: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"复式"];
            break;
        }
        case LotteryPlayType5zu120: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组选120"];
            break;
        }
        case LotteryPlayType5zu60: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组选60"];
            break;
        }
        case LotteryPlayType5zu30: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组选30"];
            break;
        }
        case LotteryPlayType5zu20: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组选20"];
            break;
        }
        case LotteryPlayType5zu10: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组选10"];
            break;
        }
        case LotteryPlayType5zu5: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组选5"];
            break;
        }
        case LotteryPlayType4zhi: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"复式"];
            break;
        }
        case LotteryPlayType4zu24: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组选24"];
            break;
        }
        case LotteryPlayType4zu12: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组选12"];
            break;
        }
        case LotteryPlayTypeQ3zhi: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"复式"];
            break;
        }
        case LotteryPlayTypeQ3zu3: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组三"];
            break;
        }
        case LotteryPlayTypeQ3zu6: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组六"];
            break;
        }
        case LotteryPlayTypeQ3zuHe: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组选和值"];
            break;
        }
        case LotteryPlayTypeQ3zuBD: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"包胆"];
            break;
        }
        case LotteryPlayTypeH3zhiF: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"复式"];
            break;
        }
        case LotteryPlayTypeH3zhiK: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"跨度"];
            break;
        }
        case LotteryPlayTypeH3zu3: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组三"];
            break;
        }
        case LotteryPlayTypeH3zu6: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组六"];
            break;
        }
        case LotteryPlayTypeH3zuHe: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"组选和值"];
            break;
        }
        case LotteryPlayTypeH3zuBD: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"包胆"];
            break;
        }
        case LotteryPlayType2zhiH2: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"后二(复式)"];
            break;
        }
        case LotteryPlayType2zhiH2He: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"后二和值"];
            break;
        }
        case LotteryPlayType2zhiH2K: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"后二跨度"];
            break;
        }
        case LotteryPlayType2zhiQ2: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"前二(复式)"];
            break;
        }
        case LotteryPlayType2zhiQ2K: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"前二跨度"];
            break;
        }
        case LotteryPlayType2zuH2: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"后二(复式)"];
            break;
        }
        case LotteryPlayType2zuQ2: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"前二(复式)"];
            break;
        }
        case LotteryPlayTypeDWD: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"定位胆"];
            break;
        }
        case LotteryPlayType3BDWH31: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"后三一码不定位"];
            break;
        }
        case LotteryPlayType3BDWH32: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"后三二码不定位"];
            break;
        }
        case LotteryPlayType3BDWQ31: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"前三一码不定位"];
            break;
        }
        case LotteryPlayType3BDWQ32: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"前三二码不定位"];
            break;
        }
        case LotteryPlayType4BDW2: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"四星二码不定位"];
            break;
        }
        case LotteryPlayType5BDW2: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"五星二码不定位"];
            break;
        }
        case LotteryPlayType5BDW3: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"五星三码不定位"];
            break;
        }
        case LotteryPlayTypeT1: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"一帆风顺"];
            break;
        }
        case LotteryPlayTypeTH: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"好事成双"];
            break;
        }
        case LotteryPlayTypeT3: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"三星报喜"];
            break;
        }
        case LotteryPlayTypeT4: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"四季发财"];
            break;
        }
        case LotteryPlayTypeSDQ3ZF: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"前三直选复式"];
 
            break;
        }
        case LotteryPlayTypeSDQ3ZuF: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"前三组选复式"];
            break;
        }
        case LotteryPlayTypeSDDWD: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"定位胆"];

            break;
        }
        case LotteryPlayTypeRXF11: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"任选一中一"];
            break;
        }
        case LotteryPlayTypeRXF22: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"任选二中二"];

            break;
        }
        case LotteryPlayTypeRXF33: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"任选三中三"];

            break;
        }
        case LotteryPlayTypeRXF44: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"任选四中四"];

            break;
        }
        case LotteryPlayTypeRXF55: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"任选五中五"];

            break;
        }
        case LotteryPlayTypeDT55: {
            option = [[LotteryPlayOption alloc] initWithType:type title:@"任选五中五"];
            
            break;
        }
            
        default: {
            break;
        }
    }
    
    return option;
}

@end
