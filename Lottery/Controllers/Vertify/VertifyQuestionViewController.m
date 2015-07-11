//
//  VertifyQuestionViewController.m
//  Lottery
//
//  Created by August on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "VertifyQuestionViewController.h"

@interface VertifyQuestionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *question1TitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *question1AnswerField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *question2TitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *question2AnswerField;

@end

@implementation VertifyQuestionViewController

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


@end
