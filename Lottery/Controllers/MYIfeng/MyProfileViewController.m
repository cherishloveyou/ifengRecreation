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
#import "SettingViewController.h"
#import "HTTPClient+User.h"
#import "LogInUserIonfoModel.h"

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeYuanJiao) name:@"yuanjiaoChange" object:nil];
    
    [self setUp];
    [self fetchData];
    [self fillSubViews];
}


- (void)changeYuanJiao{
    
    BOOL  isDisPlayYuan = [[NSUserDefaults standardUserDefaults] boolForKey:@"isYuanDisplay"];
    
    NSString *new = self.remainLabel.text;
    NSString *subString = [new substringFromIndex:1];
    
    CGFloat money = [subString floatValue];
    if (isDisPlayYuan) {
        new = [NSString stringWithFormat:@"￥%.0f",money*10];
    }else{
        new = [NSString stringWithFormat:@"￥%.2f",money/10.0];
    }
    
    self.remainLabel.text = new;
}

#pragma mark - private methods

-(void)setUp
{
//    self.navigationItem.title = @"test";
    self.navigationController.navigationBar.translucent = YES;
    [self setNavigationBarBackgroundHidden:YES];
    
    self.potraitImage.layer.cornerRadius = CGRectGetWidth(self.potraitImage.bounds)/2.0;
    self.potraitImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.potraitImage.layer.borderWidth = 1;
    
    RecordPageViewController *recordViewController = [[RecordPageViewController alloc] init];
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

-(void)fetchData
{
    [HTTPClient userHandleWithAction:UserHandlerActionBalance
                          paramaters:@{}
                             success:^(id task, id response) {
                                 NSUInteger code = [response[@"code"] integerValue];
                                 NSNumber *userMoney = response[@"userMoney"];
                                 
                                 BOOL  isDisPlayYuan = [[NSUserDefaults standardUserDefaults] boolForKey:@"isYuanDisplay"];
                                 if (code == 0 && !isDisPlayYuan) {
                                     self.remainLabel.text = [NSString stringWithFormat:@"￥%@",userMoney];
                                 }else if(code == 0 && isDisPlayYuan){
                                     
                                     CGFloat jiao = [userMoney floatValue];
                                     self.remainLabel.text = [NSString stringWithFormat:@"￥%.0f",jiao*10];
                                 }
                                 
                             } failed:^(id task, NSError *error) {
                                 NSLog(@"error is %@",error);
                             }];
}

-(void)fillSubViews
{
    LogInUserIonfoModel *user = [LogInUserIonfoModel defaultUserInfo];
    
    self.title = user.userName;
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

-(IBAction)mailButtonClicked:(id)sender
{
    
}

@end
