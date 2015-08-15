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

@property (weak, nonatomic) IBOutlet UILabel *yuanJiaoLabel;

@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;

@property (weak, nonatomic) IBOutlet UISwitch *yuanJiaoSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *notificationSwitch;

@end

@implementation SettingViewController

#pragma mark - lifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.yuanJiaoSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"isYuanDisplay"]];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isYuanDisplay"]) {
        self.yuanJiaoLabel.text = @"角";
    }else{
        self.yuanJiaoLabel.text = @"元";
    }
    
    [self.notificationSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"notificationEnable"]];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"notificationEnable"]) {
        self.notificationLabel.text =@"不接收通知";
    }else{
        self.notificationLabel.text = @"接收通知";
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
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

- (IBAction)yuanJiaoSwichValueChanged:(UISwitch*)sender {
    if (sender.on) {
        self.yuanJiaoLabel.text = @"角";
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isYuanDisplay"];
    }else{
        self.yuanJiaoLabel.text = @"元";
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isYuanDisplay"];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"yuanjiaoChange" object:nil];
}

- (IBAction)notificationSwitchValueChanged:(UISwitch*)sender {
    if (sender.on) {
        self.notificationLabel.text = @"接收通知消息";
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notificationEnable"];
    }else{
        self.notificationLabel.text = @"不接收通知消息";
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"notificationEnable"];
    }
    
}

- (IBAction)logOutButtonClicked:(id)sender {
    
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
