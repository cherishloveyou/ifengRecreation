//
//  SelectNumbersCell.h
//  Lottery
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectNumbersCell;
@protocol SelectNumbersCellDelegate <NSObject>

-(void)numbersCell:(SelectNumbersCell *)numbersCell seletedNumber:(NSInteger)selectedNumber isSelected:(BOOL)isSelected;

@end

@interface SelectNumbersCell : UITableViewCell

@property (nonatomic, weak) id<SelectNumbersCellDelegate> delegate;

-(void)fillCellWithNumbersSet:(NSMutableOrderedSet *)numbersSet;

@end
