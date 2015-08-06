//
//  RechargeViewController.m
//  Lottery
//
//  Created by August on 15/7/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "RechargeViewController.h"
#import "HTTPClient+User.h"
#import <MJRefresh.h>

@interface RechargeViewController ()

@end

@implementation RechargeViewController

static NSString *reuseIdentifier = @"bandCell";

#pragma mark - life cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
<<<<<<< Updated upstream

=======
//    NSCalendar
>>>>>>> Stashed changes
    [self setUp];
    [self fetchBankCardsInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

- (void)setUp {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (void)fetchBankCardsInfo
{
    [HTTPClient userHandleWithAction:UserHandlerActionBankCardRecharge
                          paramaters:@{@"type":@1,
                                       @"ammount":@0}
                             success:^(id task, id response) {
                                 NSLog(@"response is %@",response);
                             } failed:^(id task, NSError *error) {
                                 
                             }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    return cell;
}

@end
