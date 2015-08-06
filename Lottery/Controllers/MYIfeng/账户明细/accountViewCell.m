//
//  accountViewCell.m
//  Lottery
//
//  Created by 刘继洋 on 15/8/6.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "accountViewCell.h"

@implementation accountViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)loadDataWithDataDic:(NSDictionary *)dataDic{
    if (dataDic) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@",[dataDic valueForKey:@"explain"]];
        
        self.timeLablel.text = [NSString stringWithFormat:@"%@",[dataDic valueForKey:@"addTime"]];
        
        self.moneyLabel.text = [NSString stringWithFormat:@"%@",[dataDic valueForKey:@"changeMoney"]];
    }
}

@end
