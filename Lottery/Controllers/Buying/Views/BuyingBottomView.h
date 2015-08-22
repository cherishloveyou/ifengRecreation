//
//  BuyingBottomView.h
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BuyingBottomView;
@protocol BuyingBottomViewDelegate <NSObject>

- (void)bottomBar:(BuyingBottomView *)bottomBar leftButtonClicked:(UIButton *)sender;
- (void)bottomBar:(BuyingBottomView *)bottomBar rightButtonClicked:(UIButton *)sender;

@end

@interface BuyingBottomView : UIView

@property (nonatomic, assign) id<BuyingBottomViewDelegate> delegate;

@property (nonatomic, strong, readonly) UILabel *topLabel;
@property (nonatomic, strong, readonly) UILabel *bottomLabel;
@property (nonatomic, assign) BOOL canBuyLottery;

@end
