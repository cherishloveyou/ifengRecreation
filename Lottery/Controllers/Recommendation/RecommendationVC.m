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
#import "HTTPClient+User.h"
#import "AnnouncementVC.h"
#import "WithDrawViewController.h"
#import "RechargeViewController.h"
#import "BuyingViewController.h"
#import "NumbersBasketVC.h"

@interface RecommendationVC (){
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

@property (nonatomic,strong) UIImageView *addButtonImage;

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
//        [_hotLotteryIds addObjectsFromArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"hotLotteryIds"]];
        [_hotLotteryIds addObject:[UIImage imageNamed:@"IMG_cqssc"]];
        [_hotLotteryIds addObject:[UIImage imageNamed:@"IMG_sd11-5"]];
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
    [self refreshHotLotteryImages:self.hotLotteryIds];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
//    NSLog(@"advertisementView frame == %@",self.advertisementView);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeYuanJiao) name:@"yuanjiaoChange" object:nil];
 LoginViewController *login = [LoginViewController showFromController:self];
    __weak typeof(self) weakself = self;
    login.imageBlock = ^(NSArray *imageurls){
        //添加广告栏
        if (scrollView) {
            [scrollView removeFromSuperview];
        }
        scrollView = [[FFScrollView alloc] initPageViewWithFrame:self.advertisementView.bounds views:imageurls];
        [weakself.advertisementView addSubview:scrollView];
        
        weakself.userName.text = [NSString stringWithFormat:@"%@",[uerdictionary objectForKey:@"userName"]];
         NSNumber *userMoney = [uerdictionary objectForKey:@"userMoney"] ;
        
        BOOL isdisPlauJiao = [[NSUserDefaults standardUserDefaults] boolForKey:@"isYuanDisplay"];
        if ( !isdisPlauJiao) {
            self.balance.text = [NSString stringWithFormat:@"￥%@",userMoney];
        }else if(isdisPlauJiao){
            
            CGFloat jiao = [userMoney floatValue];
            self.balance.text = [NSString stringWithFormat:@"￥%.0f",jiao*10];
        }
//        weakself.balance.text = [NSString stringWithFormat:@"%@",[uerdictionary objectForKey:@"userMoney"]];
        weakself.yesterdayMony.text = [NSString stringWithFormat:@"%@",[uerdictionary objectForKey:@"yesterDayRewards"]];
        
        [weakself getTheLastLotteryNumber];
    };
    if ( sCREENWIDTH > 320 && sCREENWIDTH <= 375) {
        NSLog(@"%f",sCREENWIDTH);
        self.rightFirstConstraint.constant = -35;
    }else if(sCREENWIDTH > 375){
        self.rightFirstConstraint.constant = -55;
    }
    
}

- (void)changeYuanJiao{
    
    BOOL  isDisPlayYuan = [[NSUserDefaults standardUserDefaults] boolForKey:@"isYuanDisplay"];
    
    NSString *new = self.balance.text;
    NSString *subString = [new substringFromIndex:1];
    
    CGFloat money = [subString floatValue];
    if (isDisPlayYuan) {
        new = [NSString stringWithFormat:@"￥%.0f",money*10];
    }else{
        new = [NSString stringWithFormat:@"￥%.2f",money/10.0];
    }
    
    self.balance.text = new;
}

/**
 *  获取重庆时时彩 最近一期号码
 */
- (void)getTheLastLotteryNumber{
    
    [HTTPClient userHandleWithAction:14 paramaters:@{@"lotteryType":@"1"} success:^(id task, id response) {
        NSInteger code = [[response objectForKey:@"code"] integerValue];
        if (!code) {
            [self loadRatherNumbersWithdic:response];
        }
        
    } failed:^(id task, NSError *error) {
        
    }];
}
/**
 *  显示开奖号码
 *
 *  @param datadic 开奖结果
 */
- (void)loadRatherNumbersWithdic:(NSDictionary*)datadic{
    NSString *termNum = [NSString stringWithFormat:@"第%@期",[datadic objectForKey:@"termNum"]];
    self.lotteryStage.text = termNum;
    NSString *ratherNum = [datadic objectForKey:@"ratherNum"];
    
    for (int i = 0; i<ratherNum.length; i++) {
        NSString *subString = [ratherNum substringWithRange:NSMakeRange(i, 1)];
        if (i<self.numbers.count) {
            UIImageView *numberimage =  self.numbers[i];
            numberimage.image = [UIImage imageNamed:subString];
        }
    }
    
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
        }else if (tapImageView != self.addButtonImage){
            //跳转至购买彩票页面
            NSInteger imageTag = tapImageView.tag;
            BuyingViewController *buyIng = [[BuyingViewController alloc] initWithNibName:@"BuyingViewController" bundle:[NSBundle mainBundle]];
            if (imageTag == 0) {//到重庆时时彩
                buyIng.lotteryType = LotteryTypeChongQingShiShiCai;
                buyIng.title = @"重庆时时彩";
            }else if(imageTag == 1){//山东十一选5
                buyIng.lotteryType = LotteryTypeShandongShiYiXuanWu;
                buyIng.title = @"山东11选5";
            }
            buyIng.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:buyIng animated:YES];
            return;
        }
    }
    
    ChooseLotteryVC *chooseLottery = [[ChooseLotteryVC alloc] initWithNibName:@"ChooseLotteryVC" bundle:[NSBundle mainBundle]];
    
    chooseLottery.hotLotteryIds = self.hotLotteryIds;
    
    __weak typeof(self) weakSelf = self;
    //选择热门彩票后回调
    chooseLottery.selectLotteryBlock = ^(NSMutableArray *lotteryArray){
        weakSelf.hotLotteryIds = [NSMutableArray arrayWithArray:lotteryArray];
        
        [weakSelf refreshHotLotteryImages:weakSelf.hotLotteryIds];
    };
    [SVProgressHUD showInfoWithStatus:@"更多精彩彩票建设中，敬请期待!"];
    
//    [self presentViewController:chooseLottery animated:YES completion:nil];
    
}

/**
 *  刷新
 */
- (void)refreshHotLotteryImages:(NSArray*)hotlottery{
    
    if (hotlottery.count < 6) {
        for (int i = 0; i < hotlottery.count; i++) {
            UIImageView *imageView = self.lotteryArray[i];
            [imageView setImage:hotlottery[i]];
        }
        UIImageView *addImage = self.lotteryArray[hotlottery.count];
        [addImage setImage:[UIImage imageNamed:@"IMG_1294"]];
        self.addButtonImage = addImage;
    }else if(hotlottery.count == 6){
        for (int i = 0; i < hotlottery.count; i++) {
            UIImageView *imageView = self.lotteryArray[i];
            [imageView setImage:hotlottery[i]];
        }
    }
    
}

/**
 *  彩票投注跳转至重庆时时彩 购彩页面
 *
 *  @param sender
 */
- (IBAction)goToBet:(id)sender {
    
    BuyingViewController *buyIng = [[BuyingViewController alloc] initWithNibName:@"BuyingViewController" bundle:[NSBundle mainBundle]];
    buyIng.lotteryType = LotteryTypeChongQingShiShiCai;
    buyIng.title = @"重庆时时彩";
    buyIng.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:buyIng animated:YES];
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
        [self.usetinfoView setNeedsLayout];
        [UIView animateWithDuration:.5 animations:^{
            self.infoViewConstraint.constant = 0;
            grayBackViewf.alpha = 0.8;
            [self.usetinfoView layoutIfNeeded];
        }];
        
        
    }else{
        sender.selected = NO;
//        self.infoViewConstraint.constant = -190;
        [UIView animateWithDuration:.5 animations:^{
            grayBackViewf.alpha = 0.01;
            self.infoViewConstraint.constant = -190;
            [self.usetinfoView layoutIfNeeded];
        }completion:^(BOOL finished) {
            self.usetinfoView.hidden = YES;
            [grayBackViewf removeFromSuperview];
            grayBackViewf = nil;
        }];
        
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
    self.dropDownButton.selected = NO;
//    self.infoViewConstraint.constant = -190;
//    self.usetinfoView.hidden = YES;
    [self.usetinfoView setNeedsLayout];
    [UIView animateWithDuration:.5 animations:^{
        grayBackViewf.alpha = 0.01;
        self.infoViewConstraint.constant = -190;
        [self.usetinfoView layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.usetinfoView.hidden = YES;
        [grayBackViewf removeFromSuperview];
        grayBackViewf = nil;
    }];
    grayBackViewf = nil;
    
    RechargeViewController *rechargeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"RechargeViewController"];
    [self.navigationController pushViewController:rechargeVC animated:YES];
    
}
/**
 *  提现
 *
 *  @param sender
 */
- (IBAction)toWithdrawMoney:(id)sender{
    self.dropDownButton.selected = NO;
//    self.infoViewConstraint.constant = -190;
    
    [self.usetinfoView setNeedsLayout];
    [UIView animateWithDuration:.5 animations:^{
        grayBackViewf.alpha = 0.01;
        self.infoViewConstraint.constant = -190;
        [self.usetinfoView layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.usetinfoView.hidden = YES;
        [grayBackViewf removeFromSuperview];
        grayBackViewf = nil;
    }];
//    self.usetinfoView.hidden = YES;
    grayBackViewf = nil;
    WithDrawViewController *drawVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"WithDrawViewController"];
    [self.navigationController pushViewController:drawVC animated:YES];
    
}
/**
 *  投注记录
 *
 *  @param sender
 */
- (IBAction)recordOfBuy:(id)sender{
    self.dropDownButton.selected = NO;
    [grayBackViewf removeFromSuperview];
//    self.usetinfoView.hidden = YES;
    
    [self.usetinfoView setNeedsLayout];
    [UIView animateWithDuration:.5 animations:^{
        grayBackViewf.alpha = 0.01;
        self.infoViewConstraint.constant = -190;
        [self.usetinfoView layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.usetinfoView.hidden = YES;
        [grayBackViewf removeFromSuperview];
        grayBackViewf = nil;
    }];
    
    grayBackViewf = nil;
    
    [self.tabBarController setSelectedIndex:3];
}
/**
 *  信息中心
 *
 *  @param sender 
 */
- (IBAction)myMessage:(id)sender{
    self.dropDownButton.selected = NO;
//    self.infoViewConstraint.constant = -190;
//    self.usetinfoView.hidden = YES;
    
    [self.usetinfoView setNeedsLayout];
    [UIView animateWithDuration:.5 animations:^{
        grayBackViewf.alpha = 0.01;
        self.infoViewConstraint.constant = -190;
        [self.usetinfoView layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.usetinfoView.hidden = YES;
        [grayBackViewf removeFromSuperview];
        grayBackViewf = nil;
    }];
    
    AnnouncementVC *announcementVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AnnouncementVC"];
    [self.navigationController pushViewController:announcementVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
