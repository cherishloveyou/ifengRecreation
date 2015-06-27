//
//  NumberCellNode.h
//  Lottery
//
//  Created by August on 15/6/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberCellNode : NSObject

@property (nonatomic, strong) NSMutableOrderedSet *numbersSet;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSUInteger segmentSelectIndex;

@end
