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

@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation RecommendViewController

#pragma lifecycle methods

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self baseConfigs];
}

#pragma mark - private methods

-(void)baseConfigs
{
#warning 只是用来测试
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [HTTPClient userHandleWithAction:UserHandlerActionLoginValidate
                          paramaters:@{@"uname":@"yulin005",
                                       @"pwd":@"123456"}
                             success:^(id task, id response) {
                                 
                             } failed:^(id task, NSError *error) {
                                 
                             }];
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
    BuyingViewController *buyingViewControlelr = [[BuyingViewController alloc] initWithNibName:@"BuyingViewController" bundle:nil];
    
    [self.navigationController pushViewController:buyingViewControlelr animated:YES];
}

@end
