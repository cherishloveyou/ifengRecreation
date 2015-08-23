//
//  BuyingDropMenuViewController.h
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>
#import "LotteryPlayOption.h"
#import "NumbersBasketCell.h"

extern NSString *const TouchBackgroundNotification;

@class BuyingDropMenuViewController;
@protocol BuyingDropMenuViewControllerDelegate <NSObject>

- (void)dropMenuController:(BuyingDropMenuViewController *)controller didSelectMenuItemAtIndexPath:(NSIndexPath *)indexPath option:(LotteryPlayOption *)option;

@end

@interface BuyingDropMenuViewController : UIViewController

@property (nonatomic, assign) LotteryType lotteryType;
@property (nonatomic, weak) id<BuyingDropMenuViewControllerDelegate> delegate;

- (void)showDropMenuInViewController:(UIViewController *)viewController frame:(CGRect)frame completion:(void(^)(void))completion;
- (void)dismissDropMenuCompletion:(void(^)(void))completion;

@end
