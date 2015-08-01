//
//  LotteryGlobal.m
//  Lottery
//
//  Created by August on 15/8/1.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "LotteryGlobal.h"

@implementation LotteryGlobal

UIColor * ColorRGB(CGFloat r,CGFloat g,CGFloat b) {
    return ColorRGBA(r, g, b, 1);
}

UIColor * ColorRGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}


@end
