//
//  ModifyPasswordViewController.m
//  Lottery
//
//  Created by August on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import <ReactiveCocoa.h>
#import "HTTPClient+User.h"

@interface ModifyPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *currentTextField;
@property (weak, nonatomic) IBOutlet UITextField *theNewTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneItem;

@end

@implementation ModifyPasswordViewController

#pragma mark - lifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
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
    RAC(self.doneItem,enabled) = [RACSignal combineLatest:@[self.currentTextField.rac_textSignal,self.theNewTextField.rac_textSignal,self.confirmTextField.rac_textSignal] reduce:^(NSString *old,NSString *new, NSString *confirm){
        return @(old.length > 0 && new.length > 0 && confirm.length > 0);
    }];
}

#pragma mark -  event methdos

- (IBAction)doneItemClicked:(id)sender {
    UserHandlerAction action = UserHandlerActionModifySafePassword;
    if (self.modifyType == PasswordTypeLogin) {
        action = UserHandlerActionModifyLoginPassword;
    }
    
    [HTTPClient userHandleWithAction:action
                          paramaters:@{@"currentPwd":self.currentTextField.text,
                                       @"newPwd":self.theNewTextField.text,@"confrimPwd":self.confirmTextField.text}
                             success:^(id task, id response) {
                                 [self.navigationController popViewControllerAnimated:YES];
                             } failed:^(id task, NSError *error) {
                                 
                             }];
}

@end
