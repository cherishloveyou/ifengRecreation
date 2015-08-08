//
//  DropMenuNode.m
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "DropMenuNode.h"

@implementation DropMenuNode

- (instancetype)initWithTitle:(NSString *)title options:(NSArray *)options {
    self = [super init];
    if (self) {
        self.title = [title copy];
        self.options = options;
    }
    return self;
}

@end
