//
//  ChooseLotteryVC.m
//  Lottery
//
//  Created by 刘继洋 on 15/6/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ChooseLotteryVC.h"

@interface ChooseLotteryVC ()

@end

@implementation ChooseLotteryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  关闭
 *
 *  @param sender
 */
- (IBAction)closePage:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  完成选择
 *
 *  @param sender
 */

- (IBAction)choosedLotteryDone:(id)sender{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
