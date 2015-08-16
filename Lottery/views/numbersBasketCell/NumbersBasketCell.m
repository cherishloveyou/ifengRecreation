//
//  NumbersBasketCell.m
//  Lottery
//
//  Created by 刘继洋 on 15/8/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "NumbersBasketCell.h"

@implementation NumbersBasketCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpWithNumebrdic:(NSDictionary *)numersdic{
    
    self.numbersLabel.text = [numersdic allValues][0];
    self.playPlanName.text = [numersdic allKeys][0];
    NSString *number = [numersdic allValues][0];
    NSInteger sum = 1;
    NSArray *array = [number componentsSeparatedByString:@","];
    for (NSString *subString in array) {
        if (self.lotteryType == LotteryTypeChongQingShiShiCai) {
            sum = sum * subString.length;
        }else{
            sum = sum * (subString.length/2);
        }
    }
    self.calculateFormulaLabel.text = [NSString stringWithFormat:@"%ld注x0.2元=%.2f元",sum,sum*0.2];
}


- (void)setIsEditing:(BOOL)isEditing{
    
    self.deleteButton.hidden = !isEditing;
    
}

- (IBAction)deleteCurrentCell:(id)sender {
    
    NumbersBasketDeleteBlock block = self.deleteBlock;
    if (block) {
        block(self.indexPath);
    }
    
}


@end
