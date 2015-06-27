//
//  NumberCellNode.m
//  Lottery
//
//  Created by August on 15/6/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "NumberCellNode.h"

@implementation NumberCellNode

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.numbersSet = [NSMutableOrderedSet orderedSet];
        self.segmentSelectIndex = NSNotFound;
    }
    return self;
}

@end
