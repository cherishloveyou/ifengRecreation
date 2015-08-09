//
//  DropMenuCell.h
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropMenuNode.h"

@class DropMenuCell;
@protocol DropMenuCellDelegate <NSObject>

- (void)dropMenuCell:(DropMenuCell *)cell didSelectedItemAtIndex:(NSUInteger)index title:(NSString *)title;

@end

@interface DropMenuCell : UITableViewCell

@property (nonatomic, weak) id<DropMenuCellDelegate> delegate;

- (instancetype)initWithIndex:(NSUInteger)index reuseIdentifier:(NSString *)identifier;

- (void)fillCellWithNode:(DropMenuNode *)node;

@end
