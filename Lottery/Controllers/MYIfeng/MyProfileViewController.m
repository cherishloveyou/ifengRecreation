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

@property (nonatomic, weak) UIView *pageView;


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
#warning 还没有添加controller
    RecordPageViewController *recordViewController = [[RecordPageViewController alloc] initWithControllers:nil];
    [recordViewController willMoveToParentViewController:self];
    [self addChildViewController:recordViewController];
    [self.view addSubview:recordViewController.view];
    [recordViewController didMoveToParentViewController:self];
    
    [recordViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(@0);
        make.top.equalTo(self.topContainerView.mas_bottom);
    }];
    
    self.pageView = recordViewController.view;
    
    UISwipeGestureRecognizer *swipDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipDown.direction = UISwipeGestureRecognizerDirectionDown;
    [recordViewController.view addGestureRecognizer:swipDown];
    
    UISwipeGestureRecognizer *swipUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipUp.direction = UISwipeGestureRecognizerDirectionUp;
    [recordViewController.view addGestureRecognizer:swipUp];
}

#pragma mark - event methods

-(void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    UISwipeGestureRecognizerDirection direction = swipe.direction;
    if (direction == UISwipeGestureRecognizerDirectionDown) {
        [self.pageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.equalTo(@0);
            make.top.equalTo(self.topContainerView.mas_bottom);
        }];
    }else{
        [self.pageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.equalTo(@0);
            make.top.equalTo(@64);
        }];
    }
    
    [self.view setNeedsLayout];
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.view layoutIfNeeded];
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
