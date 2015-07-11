//
//  BankCardManageViewController.m
//  Lottery
//
//  Created by August on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "BankCardManageViewController.h"

@interface BankCardManageViewController ()

@property (nonatomic, strong) NSMutableArray *bankCards;
@property (weak, nonatomic) IBOutlet UIButton *addCardButton;
@property (weak, nonatomic) IBOutlet UILabel *footerTitleLabel;

@end

@implementation BankCardManageViewController

#pragma mark - lifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)dealloc
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

#pragma mark -  event methdos

- (IBAction)addCardButtonClicked:(id)sender {
    
}


#pragma mark - UITableViewDataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankCard" forIndexPath:indexPath];
    
    cell.textLabel.text = @"test";
    cell.detailTextLabel.text = @"q1241341";
    return cell;
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
