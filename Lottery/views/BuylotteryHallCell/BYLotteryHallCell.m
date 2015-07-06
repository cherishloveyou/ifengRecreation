//
//  BYLotteryHallCell.m
//  Lottery
//
//  Created by 刘继洋 on 15/6/14.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "BYLotteryHallCell.h"
#import <UIImageView+WebCache.h>

@implementation BYLotteryHallCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  装载数据
 *
 *  @param dataDic 数据源
 */
- (void)loadDataWithDataDictionary:(NSDictionary *)dataDic{
    
    self.lotteryNameLabel.text = [dataDic objectForKey:@"_gameName"];
    self.lotterySnippetLabel.text = [dataDic objectForKey:@"_gameName"];
    [self.lotteryHeaderImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"header"]];
}

@end
