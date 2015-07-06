//
//  LotteryResultsCell.m
//  Lottery
//
//  Created by 刘继洋 on 15/6/15.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "LotteryResultsCell.h"

@interface LotteryResultsCell ()
/**
 *  全局
 */
{
    /**
     *  最新开奖号码（号码图片）
     */
    __weak IBOutlet UIImageView *_firstImage;
    
    __weak IBOutlet UIImageView *_secondImage;
    
    __weak IBOutlet UIImageView *_ThirdImage;
    
    __weak IBOutlet UIImageView *_fourthImage;
    
    __weak IBOutlet UIImageView *_fifthImage;
    /**
     *  上一期开奖号码（Label）
     */
    __weak IBOutlet UILabel *_firstLabelT;
    
    __weak IBOutlet UILabel *_secondLabelT;
    
    __weak IBOutlet UILabel *_thirdLabelT;
    
    __weak IBOutlet UILabel *_fourthLabelT;
    
    __weak IBOutlet UILabel *_fifthLabelT;
    /**
     *  上上期开奖号码（Label）
     */
    __weak IBOutlet UILabel *_firstLabelTh;
    
    __weak IBOutlet UILabel *_secondLabelTh;
    
    __weak IBOutlet UILabel *_thirdLabelTh;
    
    __weak IBOutlet UILabel *_fourthLabelTh;
    
    __weak IBOutlet UILabel *_fifthLabelTh;
    
}

@end

@implementation LotteryResultsCell

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
 *  @param dataArray 数据源
 */
- (void)loadDataWithArray:(NSArray*)dataArray{
    
}

@end
