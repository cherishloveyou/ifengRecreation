//
//  SettingViewController.m
//  Lottery
//
//  Created by August on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "SettingViewController.h"
#import "ModifyPasswordViewController.h"

NSString *const ModifyLoginPasswordSegue = @"ModifyLoginPassword";
NSString *const ModifySafePasswordSegue = @"ModifySafePassword";

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:ModifySafePasswordSegue]) {
        ModifyPasswordViewController *password = segue.destinationViewController;
        password.modifyType = PasswordTypeSafe;
    }else if ([segue.identifier isEqualToString:ModifyLoginPasswordSegue]) {
        ModifyPasswordViewController *password = segue.destinationViewController;
        password.modifyType = PasswordTypeLogin;

    }
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
