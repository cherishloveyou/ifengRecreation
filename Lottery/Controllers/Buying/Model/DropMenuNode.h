//
//  DropMenuNode.h
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DropMenuNode : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *options;

- (instancetype)initWithTitle:(NSString *)title options:(NSArray *)options;

@end
