//
//  ChooseLotteryCell.h
//  Lottery
//
//  Created by 刘继洋 on 15/6/29.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseLotteryCell : UICollectionViewCell
/**
 *  彩种图片
 */
@property (weak,nonatomic) IBOutlet UIImageView *lotteryImageView;
/**
 *  是否是新彩种
 */
@property (weak,nonatomic) IBOutlet UIImageView *isNewLottery;



@end
