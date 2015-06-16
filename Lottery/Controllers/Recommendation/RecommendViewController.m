//
//  RecommendViewController.m
//  Lottery
//
//  Created by August on 15/5/24.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "RecommendViewController.h"
#import "HTTPClient+User.h"

@implementation RecommendViewController

#pragma lifecycle methods

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [HTTPClient userHandleWithAction:UserHandlerActionLoginValidate
                          paramaters:@{@"uname":@"yulin005",
                                       @"pwd":@"123456"}
                             success:^(id task, id response) {
                                 
                             } failed:^(id task, NSError *error) {
                                 
                             }];
}

#pragma mark - private methods

@end
