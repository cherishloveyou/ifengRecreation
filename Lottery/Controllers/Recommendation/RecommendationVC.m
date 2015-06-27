//
//  RecommendationVC.m
//  Lottery
//
//  Created by 刘继洋 on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "RecommendationVC.h"

@interface RecommendationVC ()

@end

@implementation RecommendationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        self.constraint1.constant = 5;
        self.constraint2.constant = 5;
        self.constraint3.constant = 5;
        self.constraint4.constant = 5;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
