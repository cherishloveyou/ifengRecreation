//
//  SelectNumbersCell.h
//  Lottery
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAStackView.h"
#import "NumberCellNode.h"

@class SelectNumbersCell;
@protocol SelectNumbersCellDelegate <NSObject>

-(void)numbersCell:(SelectNumbersCell *)numbersCell seletedNumber:(NSInteger)selectedNumber isSelected:(BOOL)isSelected;
-(void)numbersCell:(SelectNumbersCell *)numbersCell segmentTitle:(OAStackView *)segmentTitle selectIndex:(NSUInteger)selectIndex;

@end

@interface SelectNumbersCell : UITableViewCell

@property (nonatomic, weak) id<SelectNumbersCellDelegate> delegate;

- (void)fillCellWithNode:(NumberCellNode *)node;

@end
