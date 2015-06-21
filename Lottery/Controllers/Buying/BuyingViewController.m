//
//  BuyingViewController.m
//  Lottery
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "BuyingViewController.h"
#import "SelectNumbersCell.h"

@interface BuyingViewController ()<UITableViewDelegate,UITableViewDataSource,SelectNumbersCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
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
    self.datas = [NSMutableArray array];
    //5 行
    for (int i = 0; i < 15; i++) {
        [self.datas addObject:[NSMutableOrderedSet orderedSet]];
    }
    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectNumbersCell *numberCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    numberCell.delegate = self;
    [numberCell fillCellWithNumbersSet:self.datas[indexPath.row]];
    return numberCell;
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 136;
}

#pragma mark - SelectNumbersCellDelegate methods

-(void)numbersCell:(SelectNumbersCell *)numbersCell seletedNumber:(NSInteger)selectedNumber isSelected:(BOOL)isSelected
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:numbersCell];
    NSString *indexString = [NSString stringWithFormat:@"%ld",selectedNumber];
    NSMutableOrderedSet *orderSet = self.datas[indexPath.row];
    if (isSelected) {
        [orderSet addObject:indexString];
    }else{
        [orderSet removeObject:indexString];
    }
}

#pragma mark - manage memory methods

-(void)dealloc
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
