//
//  SettingViewController.m
//  Lottery
//
//  Created by August on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

@implementation SettingViewController

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

-(void)setUp
{
}

#pragma mark - event methods

- (IBAction)yuanJiaoSwichValueChanged:(id)sender {
}
- (IBAction)notificationSwitchValueChanged:(id)sender {
}

- (IBAction)logOutButtonClicked:(id)sender {
}

#pragma mark - Table view data source

@end
