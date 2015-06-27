//
//  RecommendViewController.m
//  Lottery
//
//  Created by August on 15/5/24.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "RecommendViewController.h"
#import "HTTPClient+User.h"
#import "BuyingViewController.h"
#import "LoginViewController.h"
#import "RecommendationVC.h"

@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation RecommendViewController

#pragma lifecycle methods

-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    LoginViewController *loginVC = [LoginViewController defaultLoginViewController];
//    
//    [self presentViewController:loginVC animated:YES completion:nil];
    
    [self baseConfigs];
}

#pragma mark - private methods

-(void)baseConfigs
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    

}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"test";
    return cell;
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    RecommendationVC *recommVC = [[RecommendationVC alloc] initWithNibName:@"RecommendationVC" bundle:[NSBundle mainBundle]];
//    
//    [self.navigationController pushViewController:recommVC animated:YES];

    BuyingViewController *buyingViewControlelr = [[BuyingViewController alloc] initWithNibName:@"BuyingViewController" bundle:nil];
    buyingViewControlelr.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:buyingViewControlelr animated:YES];
}

@end
