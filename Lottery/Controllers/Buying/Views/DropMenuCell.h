//
//  DropMenuCell.h
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropMenuNode.h"

@interface DropMenuCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithIndex:(NSUInteger)index reuseIdentifier:(NSString *)identifier;

- (void)fillCellWithNode:(DropMenuNode *)node;

@end
