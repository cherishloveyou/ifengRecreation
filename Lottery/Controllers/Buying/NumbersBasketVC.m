//
//  NumbersBasketVC.m
//  Lottery
//
//  Created by 刘继洋 on 15/8/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "NumbersBasketVC.h"
#import "LogInUserIonfoModel.h"
#import "HTTPClient+User.h"

@interface NumbersBasketVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
/**
 *  包含清空按钮的tablefooter
 */
@property (strong, nonatomic) IBOutlet UIView *tableFooterView;
/**
 *
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  机选一注
 */
@property (weak, nonatomic) IBOutlet UIButton *jiXuanYizhuButton;
/**
 *  机选五注
 */
@property (weak, nonatomic) IBOutlet UIButton *jiXuanWuZhuButton;
/**
 *  继续投注
 */
@property (weak, nonatomic) IBOutlet UIButton *jiXuTouZhuButton;
/**
 *  底部投注按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *touZhuButton;
/**
 *  追加倍数
 */
@property (weak, nonatomic) IBOutlet UITextField *touZhuBeiShuTextField;
/**
 *  追加期数
 */
@property (weak, nonatomic) IBOutlet UITextField *zhuiJiaQiShuTextField;
/**
 *  购买所需金额
 */
@property (weak, nonatomic) IBOutlet UILabel *buyMoneyLabel;
/**
 *  账户余额
 */
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
/**
 *  清空所有所选按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *cleanButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhuiQiBackViewBottomConstraint;
/**
 *  总计购彩金额
 */
@property (nonatomic, assign) CGFloat sumMoney;
/**
 *  编辑状态
 */
@property (nonatomic,assign) BOOL isEditing;

@property (nonatomic,strong) NSString *terNum;



@end

@implementation NumbersBasketVC

- (NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"号码篮";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keboardwillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keboardWillhidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setUpUserInterFace];
    
    [self gettermNum];
}


- (void)gettermNum{
    
    NSString *lotteryTypeStr = @"1";
    
    if (self.lotteryType == LotteryTypeChongQingShiShiCai) {
        lotteryTypeStr = @"4";
    }
    
    [HTTPClient userHandleWithAction:13 paramaters:@{@"lotteryType":lotteryTypeStr} success:^(id task, id response) {
        
        NSInteger code = [[response objectForKey:@"code"] integerValue];
        
        if (code == 0) {
            self.terNum = [response objectForKey:@"terNum"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取期号失败"];
        }
        
    } failed:^(id task, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"获取期号失败"];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  初始化用户界面
 */
- (void)setUpUserInterFace{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(toEditingCells:)];
    self.navigationItem.rightBarButtonItem = item;
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableFooterView.frame = CGRectMake(0, 0, self.view.bounds.size.width - 22, 80);
    self.tableView.tableFooterView = self.tableFooterView;
    
    self.balanceLabel.text = [NSString stringWithFormat:@"可用余额 %@元",[LogInUserIonfoModel UserMoney]];
    self.buyMoneyLabel.text = [NSString stringWithFormat:@"0注x0.2元=0.00元"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NumbersBasketCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NumbersBasketCell"];
}

#pragma mark - buttonActions
/**
 *  机选一注
 *
 *  @param sender
 */
- (IBAction)randomOne:(id)sender {
    NSMutableString *numbersString = nil;
    
    if (self.lotteryType == LotteryTypeChongQingShiShiCai) {
        numbersString = [NSMutableString stringWithFormat:@"%d",rand()%10];
        for (int i = 0; i < 4; i++) {
            [numbersString appendFormat:@",%d",rand()%10];
        }
    }else{
        int a = 0;
        while (a==0) {
            a = rand()%12;
        }
        
        if (a>9) {
            numbersString = [NSMutableString stringWithFormat:@"%d",a];
        }else{
            numbersString = [NSMutableString stringWithFormat:@"0%d",a];
        }
        int b = 0;
        while (b<4) {
            int c = rand()%12;
            if (c>0) {
                b++;
                if (c>9) {
                    [numbersString appendFormat:@",%d",c];
                }else{
                    [numbersString appendFormat:@",0%d",c];
                }
            }
        }
    }
    
    NSDictionary *adic = [NSDictionary dictionaryWithObject:numbersString forKey:@"五星直选"];
    [self.dataSourceArray addObject:adic];
    [self sumMoneyToBuyLottery];
    [self.tableView reloadData];
    
}
/**
 *  机选5注
 *
 *  @param sender
 */
- (IBAction)randomFive:(id)sender {
    for (int i = 0; i < 5; i++) {
        NSMutableString *numbersString = nil;
        
        if (self.lotteryType == LotteryTypeChongQingShiShiCai) {
            numbersString = [NSMutableString stringWithFormat:@"%d",rand()%10];
            for (int i = 0; i < 4; i++) {
                [numbersString appendFormat:@",%d",rand()%10];
            }
        }else{
            int a = 0;
            while (a==0) {
                a = rand()%12;
            }
            
            if (a>9) {
                numbersString = [NSMutableString stringWithFormat:@"%d",a];
            }else{
                numbersString = [NSMutableString stringWithFormat:@"0%d",a];
            }
            int b = 0;
            while (b<4) {
                int c = rand()%12;
                if (c>0) {
                    b++;
                    if (c>9) {
                        [numbersString appendFormat:@",%d",c];
                    }else{
                        [numbersString appendFormat:@",0%d",c];
                    }
                }
            }
        }
        
        NSDictionary *adic = [NSDictionary dictionaryWithObject:numbersString forKey:@"五星直选"];
        [self.dataSourceArray addObject:adic];
    }
    [self sumMoneyToBuyLottery];
    [self.tableView reloadData];
}
/**
 *  继续投注
 *
 *  @param sender
 */
- (IBAction)goOnToBuy:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  投注
 *
 *  @param sender
 */
- (IBAction)toBuyCommitToConnect:(id)sender {
    
    if (!self.terNum) {
        [SVProgressHUD showErrorWithStatus:@"获取期号失败！请重新投注"];
        return;
    }
    
    NSString *lotteryTypestr = @"1";
    
    if (self.lotteryType == LotteryTypeShandongShiYiXuanWu) {
        lotteryTypestr = @"4";
    }
    
    [HTTPClient userHandleWithAction:17 paramaters:@{@"lotteryType":lotteryTypestr,@"currentNum":self.terNum,@"numberdata":self.dataSourceArray} success:^(id task, id response) {
        
        NSInteger code = [[response objectForKey:@"code"] integerValue];
        
        if (code == 0) {
            [SVProgressHUD showSuccessWithStatus:@"订单创建成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"订单创建失败"];
        }
        
    } failed:^(id task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接错误请稍后再试"];
    }];
}

/**
 *  清空所有
 *
 *  @param sender
 */
- (IBAction)cleanAllSelected:(id)sender {
    [self.dataSourceArray removeAllObjects];
    
    [self.tableView reloadData];
    [self sumMoneyToBuyLottery];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NumbersBasketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NumbersBasketCell"];
    cell.indexPath = indexPath;
    cell.lotteryType = self.lotteryType;
    cell.isEditing = self.isEditing;
    [cell setUpWithNumebrdic:self.dataSourceArray[indexPath.row]];
    
    __weak typeof(self)weakself = self;
    
    cell.deleteBlock = ^(NSIndexPath *currentIndexPath){
        [weakself.dataSourceArray removeObjectAtIndex:currentIndexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [weakself sumMoneyToBuyLottery];
        [tableView reloadData];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.;
}

- (void)keboardwillShow:(NSNotification*)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    self.zhuiQiBackViewBottomConstraint.constant = height - 52;
    
}

- (void)keboardWillhidden:(NSNotification*)notitication{
    self.zhuiQiBackViewBottomConstraint.constant = 0;
}

/**
 *  计算购买金额
 */
- (void)sumMoneyToBuyLottery{
    if (self.dataSourceArray.count>0) {
        
        NSInteger sum = self.dataSourceArray.count;
        
        for (NSDictionary *adic in self.dataSourceArray) {
            NSString *number = [adic allValues][0];
            NSArray *array = [number componentsSeparatedByString:@","];
            for (NSString *subString in array) {
                if (self.lotteryType == LotteryTypeChongQingShiShiCai) {
                    sum = sum * subString.length;
                }else{
                    sum = sum * (subString.length/2);
                }
            }
        }
        
        if (self.zhuiJiaQiShuTextField.text.length > 0) {
            sum = sum * [self.zhuiJiaQiShuTextField.text integerValue];
        }
        
        if (self.touZhuBeiShuTextField.text.length > 0) {
            sum = sum * [self.touZhuBeiShuTextField.text integerValue];
        }
        
        self.sumMoney = sum * 0.2;
        
        self.buyMoneyLabel.text = [NSString stringWithFormat:@"%ld注x0.2元=%.2f元",sum,sum*0.2];
    }else{
        
        self.buyMoneyLabel.text = [NSString stringWithFormat:@"0注x0.2元=0.00元"];
    }
    
}
/**
 *  开启编辑状态
 */
- (void)toEditingCells:(id)sender{
    
    self.isEditing = !self.isEditing;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    [self sumMoneyToBuyLottery];
    return YES;
}

@end
