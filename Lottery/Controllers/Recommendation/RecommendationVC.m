//
//  RecommendationVC.m
//  Lottery
//
//  Created by 刘继洋 on 15/6/25.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "RecommendationVC.h"
#import "LoginViewController.h"
#import "ChooseLotteryVC.h"
#import "FFScrollView.h"
#import "LoginViewController.h"

@interface RecommendationVC ()
{
    //显示彩票种类
    __weak IBOutlet UIImageView *firstImage;
    __weak IBOutlet UIImageView *secondImage;
    __weak IBOutlet UIImageView *thirdImage;
    __weak IBOutlet UIImageView *fourthImage;
    __weak IBOutlet UIImageView *fifthImage;
    __weak IBOutlet UIImageView *sixthImage;
    //时时彩开奖号码
    __weak IBOutlet UIImageView *first;
    __weak IBOutlet UIImageView *second;
    __weak IBOutlet UIImageView *third;
    __weak IBOutlet UIImageView *fourth;
    __weak IBOutlet UIImageView *fifth;
    //灰色背景
    UIView *grayBackViewf;
    //广告栏
    FFScrollView *scrollView;
    
}

@end

@implementation RecommendationVC

- (NSArray *)lotteryArray{
    if (!_lotteryArray) {
        _lotteryArray = @[firstImage,secondImage,thirdImage,fourthImage,fifthImage,sixthImage];
    }
    return _lotteryArray;
}

- (NSMutableArray *)hotLotteryIds{
    if (!_hotLotteryIds) {
        
        _hotLotteryIds = [NSMutableArray array];
        [_hotLotteryIds addObjectsFromArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"hotLotteryIds"]];
    }
    return _hotLotteryIds;
}

- (NSArray *)numbers{
    if (!_numbers) {
        _numbers = @[first,second,third,fourth,fifth];
    }
    return _numbers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
//    NSLog(@"advertisementView frame == %@",self.advertisementView);
    
//    LoginViewController *login = [LoginViewController showFromController:self];
//    __weak typeof(self) weakself = self;
//    login.imageBlock = ^(NSArray *imageurls){
//        //添加广告栏
//        if (scrollView) {
//            [scrollView removeFromSuperview];
//        }
//        scrollView = [[FFScrollView alloc] initPageViewWithFrame:self.advertisementView.bounds views:imageurls];
//        [weakself.advertisementView addSubview:scrollView];
//    };
    NSLog(@"%@",uerdictionary);
    NSArray *imageUrlArray = [uerdictionary objectForKey:@"adPictures"];
    if (scrollView) {
        [scrollView removeFromSuperview];
    }
    
    self.userName.text = [NSString stringWithFormat:@"%@",[uerdictionary objectForKey:@"userName"]];
    self.balance.text = [NSString stringWithFormat:@"%@",[uerdictionary objectForKey:@"userMoney"]];
    //添加广告栏
    scrollView = [[FFScrollView alloc] initPageViewWithFrame:self.advertisementView.bounds views:imageUrlArray];
    
    [self.advertisementView addSubview:scrollView];
    
    [self refreshHotLotteryImages:self.hotLotteryIds];
    
}
/**
 *  获取重庆时时彩 最近一期号码
 */
- (void)getTheLastLotteryNumber{
    
}
/**
 *  彩票图片点击(跳转至选择彩票)
 *
 *  @param sender
 */
- (IBAction)tapOnImage:(id)sender {
    
    if (![sender isKindOfClass:[UIButton class]]) {
        
        UITapGestureRecognizer *tap = sender;
        UIImageView *tapImageView = (UIImageView*)tap.view;
        if (!tapImageView.image) {
            return;
        }else if (![tapImageView.image isEqual:[UIImage imageNamed:@"IMG_1294"]]){
            //跳转至购买彩票页面
#warning 跳转至对应彩票购买页
            NSInteger imageTag = tapImageView.tag;
            NSLog(@"%d",imageTag);
            
            return;
        }
    }
    
    ChooseLotteryVC *chooseLottery = [[ChooseLotteryVC alloc] initWithNibName:@"ChooseLotteryVC" bundle:[NSBundle mainBundle]];
    
    chooseLottery.hotLotteryIds = self.hotLotteryIds;
    
    __weak typeof(self) weakSelf = self;
    
    chooseLottery.selectLotteryBlock = ^(NSMutableArray *lotteryArray){
        weakSelf.hotLotteryIds = [NSMutableArray arrayWithArray:lotteryArray];
        
        [weakSelf refreshHotLotteryImages:weakSelf.hotLotteryIds];
    };
    
    [self presentViewController:chooseLottery animated:YES completion:nil];
    
}

/**
 *  刷新
 */
- (void)refreshHotLotteryImages:(NSArray*)hotlottery{
    
    if (hotlottery.count < 6) {
        for (int i = 0; i < hotlottery.count; i++) {
            
        }
    }else{
        
    }
    
}

/**
 *  彩票投注跳转至重庆时时彩 购彩页面
 *
 *  @param sender
 */
- (IBAction)goToBet:(id)sender {
#warning 跳转至重庆时时彩购买页
    
}

/**
 *  下拉显示个人信息
 *
 *  @param sender 
 */
- (IBAction)showUserInfoMation:(UIButton*)sender{
    
    if (!grayBackViewf) {
        grayBackViewf = [[UIView alloc] initWithFrame:self.backScrollView.bounds];
    }
    if (!sender.selected) {
        self.usetinfoView.hidden = NO;
        
        sender.selected = YES;
        grayBackViewf.backgroundColor = [UIColor grayColor];
        grayBackViewf.alpha = 0.000001;
        [self.backScrollView insertSubview:grayBackViewf belowSubview:self.usetinfoView];
        [UIView animateWithDuration:.5 animations:^{
            self.infoViewConstraint.constant = 0;
            grayBackViewf.alpha = 0.8;
        }];
        
        
    }else{
        sender.selected = NO;
        [grayBackViewf removeFromSuperview];
        self.infoViewConstraint.constant = -190;
        self.usetinfoView.hidden = YES;
        grayBackViewf = nil;
    }
}

#pragma mark -- 下拉view的 按钮点击事件
/**
 *  充值
 *
 *  @param sender
 */
- (IBAction)topupMoney:(id)sender{
    
}
/**
 *  提现
 *
 *  @param sender
 */
- (IBAction)toWithdrawMoney:(id)sender{
    
}
/**
 *  投注记录
 *
 *  @param sender
 */
- (IBAction)recordOfBuy:(id)sender{
    
}
/**
 *  信息中心
 *
 *  @param sender 
 */
- (IBAction)myMessage:(id)sender{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    self.navigationController.navigationBarHidden = NO;

}



@end
