//
//  BuyingBottomView.h
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyingBottomView : UIView

@property (nonatomic, assign) NSUInteger hasSelectedCount;
@property (nonatomic, assign) CGFloat totalMoney;
@property (nonatomic, strong, readonly) UILabel *bottomLabel;

@end
