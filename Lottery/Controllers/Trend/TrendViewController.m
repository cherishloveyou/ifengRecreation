//
//  TrendViewController.m
//  Lottery
//
//  Created by August on 15/5/24.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "TrendViewController.h"
#import "HTTPClient+User.h"

@implementation TrendViewController


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [SVProgressHUD show];
    [HTTPClient userHandleWithAction:21 paramaters:nil success:^(id task, id response) {
        NSLog(@"%@",response);
        [SVProgressHUD showSuccessWithStatus:nil];
    } failed:^(id task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

@end
