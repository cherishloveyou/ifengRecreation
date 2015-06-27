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
    
<<<<<<< Updated upstream
//    LoginViewController *loginVC = [LoginViewController defaultLoginViewController];
//    
//    [self presentViewController:loginVC animated:YES completion:nil];
    
    [self baseConfigs];
}
=======
    if (CURRENTLOGINFLAG.length < 10) {
        LoginViewController *loginVC = [LoginViewController defaultLoginViewController];
        
//        [self presentViewController:loginVC animated:YES completion:nil];
>>>>>>> Stashed changes

    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

<<<<<<< Updated upstream
#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    RecommendationVC *recommVC = [[RecommendationVC alloc] initWithNibName:@"RecommendationVC" bundle:[NSBundle mainBundle]];
//    
//    [self.navigationController pushViewController:recommVC animated:YES];

    BuyingViewController *buyingViewControlelr = [[BuyingViewController alloc] initWithNibName:@"BuyingViewController" bundle:nil];
    buyingViewControlelr.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:buyingViewControlelr animated:YES];
=======
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
>>>>>>> Stashed changes
}


@end
