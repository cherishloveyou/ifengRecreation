//
//  BuyingDropMenuViewController.m
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "BuyingDropMenuViewController.h"
#import "DropMenuCell.h"

@interface BuyingDropMenuViewController ()

@property (nonatomic, strong) NSMutableArray *menuDatas;

@end

@implementation BuyingDropMenuViewController

#pragma mark - lifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

- (void)dealloc {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

- (void)setUp {
    [self.tableView registerNib:[UINib nibWithNibName:@"DropMenuCell" bundle:nil] forCellReuseIdentifier:@"DropMenuCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DropMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropMenuCell" forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
