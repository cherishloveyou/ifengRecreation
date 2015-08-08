//
//  BuyingDropMenuViewController.h
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyingDropMenuViewController : UIViewController

- (void)expandTableView;
- (void)closeTableView;

- (void)showDropMenuInViewController:(UIViewController *)viewController frame:(CGRect)frame completion:(void(^)(void))completion;
- (void)dismissDropMenuCompletion:(void(^)(void))completion;

@end
