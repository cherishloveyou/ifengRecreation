//
//  ModifyPasswordViewController.h
//  Lottery
//
//  Created by August on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PasswordType) {
    PasswordTypeLogin,
    PasswordTypeSafe,
};

@interface ModifyPasswordViewController : UITableViewController

@property (assign, nonatomic) PasswordType modifyType;

@end
