//
//  UIAlertView+DisMiss.m
//  Lottery
//
//  Created by 刘继洋 on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "UIAlertView+DisMiss.h"

@implementation UIAlertView (DisMiss)


/**
 *  alertView显示几秒后消失
 */
- (void)showOntime:(NSTimeInterval)timeInterval{
    
    [self show];
    
    [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(dismissWithNoButton) userInfo:nil repeats:NO];
    
}

- (void)dismissWithNoButton{
    
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

@end
