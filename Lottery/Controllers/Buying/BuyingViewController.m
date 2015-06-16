//
//  BuyingViewController.m
//  Lottery
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "BuyingViewController.h"
#import "SelectNumbersCell.h"

@interface BuyingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BuyingViewController

static NSString *reuseIdentifier = @"SelectNumbersCell";

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseConfigs];
}

#pragma mark - private methods

-(void)baseConfigs
{
    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectNumbersCell *numberCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        
    return numberCell;
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}

#pragma mark - manage memory methods

-(void)dealloc
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
