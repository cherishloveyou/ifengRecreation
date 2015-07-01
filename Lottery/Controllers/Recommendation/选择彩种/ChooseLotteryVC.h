//
//  ChooseLotteryVC.h
//  Lottery
//
//  Created by 刘继洋 on 15/6/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectLotterysBlock)(NSMutableArray* hotLotteryIds);

@interface ChooseLotteryVC : UIViewController
/**
 *  彩种列表
 */
@property(weak,nonatomic) IBOutlet UICollectionView *collectionView;

/**
 *  存放 热门彩种的购买链接或者id
 */
@property (strong, nonatomic)  NSMutableArray *hotLotteryIds;
/**
 *  选择热门彩票 完成回调
 */
@property (copy) selectLotterysBlock selectLotteryBlock;



@end
