//
//  MyProfileViewController.m
//  Lottery
//
//  Created by August on 15/5/24.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "MyProfileViewController.h"
#import "UINavigationController+JZExtension.h"
#import "RecordPageViewController.h"
#import <Masonry.h>

@interface MyProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *potraitImage;
@property (weak, nonatomic) IBOutlet UILabel *remainLabel;
@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (weak, nonatomic) IBOutlet UIButton *PayButton;
@property (weak, nonatomic) IBOutlet UIButton *kitingButton;
@property (weak, nonatomic) IBOutlet UIView *topContainerView;


@end

@implementation MyProfileViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUp];
}

#pragma mark - private methods

-(void)setUp
{
    self.navigationItem.title = @"test";
    self.navigationController.navigationBar.translucent = YES;
    [self setNavigationBarBackgroundHidden:YES];
    
    self.potraitImage.layer.cornerRadius = CGRectGetWidth(self.potraitImage.bounds)/2.0;
    self.potraitImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.potraitImage.layer.borderWidth = 1;
    
//    UIButton *mailButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [mailButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
//    [mailButton addTarget:self action:@selector(mailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mailButton];
//    
//    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [settingButton addTarget:self action:@selector(settingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [settingButton setImage:[UIImage imageNamed:@"info"] forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    
    RecordPageViewController *recordViewController = [[RecordPageViewController alloc] init];
    [recordViewController willMoveToParentViewController:self];
    [self addChildViewController:recordViewController];
    [self.view addSubview:recordViewController.view];
    [recordViewController didMoveToParentViewController:self];
    
    [recordViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(@0);
        make.top.equalTo(self.topContainerView.mas_bottom);
    }];
}

#pragma mark - event methods

-(void)mailButtonClicked:(id)sender
{
    NSLog(@"mail");
}

-(void)settingButtonClicked:(id)sender
{
    NSLog(@"setting");
}

@end
