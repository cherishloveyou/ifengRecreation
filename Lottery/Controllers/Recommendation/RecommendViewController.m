//
//  RecommendViewController.m
//  Lottery
//
//  Created by August on 15/5/24.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "RecommendViewController.h"
#import "LoginViewController.h"
#import "RecommendationVC.h"
#import "Macros.h"

@interface RecommendViewController ()

@end

@implementation RecommendViewController

#pragma lifecycle methods

-(void)viewDidLoad
{
    [super viewDidLoad];
    RecommendationVC *recmment = [[RecommendationVC alloc] initWithNibName:@"RecommendationVC" bundle:[NSBundle mainBundle]];
    [self addChildViewController:recmment];
    recmment.view.frame = self.view.bounds;
    [self.view addSubview:recmment.view];
    
    [LogInUserIonfoModel userName];
    
    [LogInUserIonfoModel userId];
    
    [LogInUserIonfoModel userType];
    
//    if (CURRENTLOGINFLAG.length < 10) {
//    LoginViewController *loginVC = [LoginViewController defaultLoginViewController];
//    
//    loginVC.imageBlock = ^(NSArray *urlsArray){
//        
//        
//    };
//    [self presentViewController:loginVC animated:YES completion:nil];

//    }

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}


@end
