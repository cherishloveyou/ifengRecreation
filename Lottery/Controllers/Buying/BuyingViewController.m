//
//  BuyingViewController.m
//  Lottery
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "BuyingViewController.h"
#import "SelectNumbersCell.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Colours.h"
#import "NumberCellNode.h"
#import "ARTagListView.h"
#import <Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BuyingDropMenuViewController.h"
#import "MZTimerLabel.h"
#import "BuyingBottomView.h"
#import "LotteryPlayOption.h"
#import "NumberButton.h"

NS_INLINE NSUInteger Permutation(NSUInteger all,NSUInteger count){
    if (all < count) {
        return 0;
    }
    NSUInteger m = 1;
    for (NSUInteger i = 0; i < count; i++) {
        m = m * (all - i);
    }
    NSUInteger z = 1;
    for (NSUInteger j = 0; j < count; j++) {
        z = z * (count - j);
    }
    return m/z;
}

static NSUInteger COUNTDOWN_TIMEINTERVAL = 300;

@interface BuyingViewController ()<UITableViewDelegate,UITableViewDataSource,SelectNumbersCellDelegate,ARTagListViewDelegate,BuyingDropMenuViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UIView *topContainerView;
@property (strong, nonatomic) ARTagListView *CurrentSelectMenuList;
@property (strong, nonatomic) UIButton *topRightArrowMenuButton;
@property (nonatomic, strong) UILabel *countDwonTitleLabel;
@property (strong, nonatomic) MZTimerLabel *countdownLabel;
@property (strong, nonatomic) UIButton *shakeButton;

@property (nonatomic, assign) BOOL dropMenuIsShowed;
@property (nonatomic, strong) BuyingDropMenuViewController *dropMenu;
@property (weak, nonatomic) IBOutlet BuyingBottomView *bottomBar;
@property (nonatomic, assign) BOOL canBuyLottery;

@property (nonatomic, strong) LotteryPlayOption *selectedOption;

@end

@implementation BuyingViewController

static NSString *reuseIdentifier = @"SelectNumbersCell";
static NSString *reuseIdentifier1 = @"SelectNumbersCell1";

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseConfigs];
}

#pragma mark - private methods

-(void)baseConfigs
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissDropMenu) name:TouchBackgroundNotification object:nil];
    
    self.selectedOption = [LotteryPlayOption optionWithType:LotteryPlayType5zhi];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.bottomBar.bottomLabel.text = @"每位选一个号码为一注";
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(infoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *infoItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    [self.navigationItem setRightBarButtonItem:infoItem];
    
    self.datas = [NSMutableArray array];
    [self buildDataWithOption:self.selectedOption];
    
    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier1];
    
    //
    self.CurrentSelectMenuList = [[ARTagListView alloc] init];
    [self.CurrentSelectMenuList.layer setBorderWidth:0.5];
    [self.CurrentSelectMenuList.layer setBorderColor:[UIColor fadedBlueColor].CGColor];
    self.CurrentSelectMenuList.tagListDelegate = self;
    [self.topContainerView addSubview:self.CurrentSelectMenuList];
    //menu button
    [self.CurrentSelectMenuList insertTagWithTitle:@"五星直选" atIndex:0 selected:YES];
    
    self.topRightArrowMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.topRightArrowMenuButton setImage:[UIImage imageNamed:@"drop_button"] forState:UIControlStateNormal];
    [self.topRightArrowMenuButton addTarget:self action:@selector(topRightArrowMenuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topRightArrowMenuButton.layer setBorderColor:[UIColor fadedBlueColor].CGColor];
    [self.topRightArrowMenuButton.layer setBorderWidth:0.5];
    [self.topContainerView addSubview:self.topRightArrowMenuButton];
    //
    self.countDwonTitleLabel = [[UILabel alloc] init];
    self.countDwonTitleLabel.textColor = [UIColor black50PercentColor];
    self.countDwonTitleLabel.font = [UIFont systemFontOfSize:12];
    self.countDwonTitleLabel.text = @"投注截止";
    [self.topContainerView addSubview:self.countDwonTitleLabel];
    self.countdownLabel = [[MZTimerLabel alloc] init];
    self.countdownLabel.timerType = MZTimerLabelTypeTimer;
    [self.countdownLabel setCountDownTime:COUNTDOWN_TIMEINTERVAL];
    self.countdownLabel.timeFormat = @"mm:ss";
    self.countdownLabel.font = [UIFont systemFontOfSize:11];
    @weakify(self);
    self.countdownLabel.endedBlock = ^(NSTimeInterval interval){
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.countdownLabel.textColor = [UIColor fadedBlueColor];
    [self.topContainerView addSubview:self.countdownLabel];
    [self.countdownLabel start];
    
    self.shakeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shakeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.shakeButton setTitleColor:[UIColor fadedBlueColor] forState:UIControlStateNormal];
    [self.shakeButton setImage:[UIImage imageNamed:@"yyy_jx"] forState:UIControlStateNormal];
    [self.shakeButton addTarget:self action:@selector(shakeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topContainerView addSubview:self.shakeButton];
    
    [self.topRightArrowMenuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [self.CurrentSelectMenuList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(@0);
        make.right.equalTo(self.topRightArrowMenuButton.mas_left);
        make.bottom.equalTo(self.topRightArrowMenuButton);
    }];
    
    [self.countDwonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CurrentSelectMenuList.mas_bottom);
        make.left.equalTo(@10);
        make.bottom.equalTo(@0);
    }];

    [self.countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CurrentSelectMenuList.mas_bottom);
        make.left.equalTo(self.countDwonTitleLabel.mas_right);
        make.bottom.equalTo(@0);
    }];
    
    [self.shakeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topRightArrowMenuButton.mas_bottom);
        make.right.equalTo(@-5);
        make.bottom.equalTo(@0);
    }];
}

- (void)buildDataWithOption:(LotteryPlayOption *)option {
    [self.datas removeAllObjects];
    switch (option.type) {
        case LotteryPlayType5zhi: {
            [self addNodesWithTitles:@[@"万",@"千",@"百",@"十",@"个"]];
            break;
        }
        case LotteryPlayType5zu120: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayType5zu60:
        case LotteryPlayType5zu30: {
            [self addNodesWithTitles:@[@"二重",@"单"]];
            break;
        }
        case LotteryPlayType5zu20: {
            [self addNodesWithTitles:@[@"三重",@"单"]];
            break;
        }
        case LotteryPlayType5zu10: {
            [self addNodesWithTitles:@[@"三重",@"二重"]];
            break;
        }
        case LotteryPlayType5zu5: {
            [self addNodesWithTitles:@[@"四重",@"单"]];
            break;
        }
        case LotteryPlayType4zhi: {
            [self addNodesWithTitles:@[@"千",@"百",@"十",@"个"]];
            break;
        }
        case LotteryPlayType4zu24: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayType4zu12: {
            [self addNodesWithTitles:@[@"二重",@"单"]];
            break;
        }
        case LotteryPlayTypeQ3zhi: {
            [self addNodesWithTitles:@[@"万",@"千",@"百"]];
            break;
        }
        case LotteryPlayTypeQ3zu3:
        case LotteryPlayTypeQ3zu6: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayTypeQ3zuHe: {
            [self addNodesWithTitles:@[@"组选和值"] cellType:NumberCellTypeHeZhi];
            break;
        }
        case LotteryPlayTypeQ3zuBD: {
            [self addNodesWithTitles:@[@"选"] cellType:NumberCellTypeBaoDan];
            break;
        }
        case LotteryPlayTypeH3zhiF: {
            [self addNodesWithTitles:@[@"百",@"十",@"个"]];
            break;
        }
        case LotteryPlayTypeH3zhiK:
        case LotteryPlayTypeH3zu3:
        case LotteryPlayTypeH3zu6: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayTypeH3zuHe: {
        [self addNodesWithTitles:@[@"组选和值"] cellType:NumberCellTypeHeZhi];
            break;
        }
        case LotteryPlayTypeH3zuBD: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayType2zhiH2: {
            [self addNodesWithTitles:@[@"十",@"个"]];
            break;
        }
        case LotteryPlayType2zhiH2He: {
            [self addNodesWithTitles:@[@"组选和值"] cellType:NumberCellTypeHeZhi];
            break;
        }
        case LotteryPlayType2zhiH2K: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayType2zhiQ2: {
            [self addNodesWithTitles:@[@"万",@"千"]];
            break;
        }
        case LotteryPlayType2zhiQ2K: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayType2zuH2: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayType2zuQ2: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayTypeDWD: {
            [self addNodesWithTitles:@[@"万",@"千",@"百",@"十",@"个"]];
            break;
        }
        case LotteryPlayType3BDWH31: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayType3BDWH32: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayType3BDWQ31: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayType3BDWQ32: {
            [self addNodesWithTitles:@[@"不定位"]];
            break;
        }
        case LotteryPlayType4BDW2: {
            [self addNodesWithTitles:@[@"不定位"]];
            break;
        }
        case LotteryPlayType5BDW2: {
            [self addNodesWithTitles:@[@"不定位"]];
            break;
        }
        case LotteryPlayType5BDW3: {
            [self addNodesWithTitles:@[@"不定位"]];
            break;
        }
        case LotteryPlayTypeT1: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayTypeTH: {
            [self addNodesWithTitles:@[@"二重"]];
            break;
        }
        case LotteryPlayTypeT3: {
            [self addNodesWithTitles:@[@"三重"]];
            break;
        }
        case LotteryPlayTypeT4: {
            [self addNodesWithTitles:@[@"四重"]];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)addNodesWithTitles:(NSArray *)titles {
    [self addNodesWithTitles:titles cellType:NumberCellTypeDefault];
}

- (void)addNodesWithTitles:(NSArray *)titles cellType:(NumberCellType)cellType {
    for (int i = 0; i < titles.count; i++) {
        NumberCellNode *node = [[NumberCellNode alloc] init];
        node.title = titles[i];
        node.cellType = cellType;
        [self.datas addObject:node];
    }
}

-(void)randomSelectNumbers
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    switch (self.selectedOption.type) {
        case LotteryPlayType5zhi: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayType5zu120: {
            [self generateRandomNumberWithCount:5];
            break;
        }
        case LotteryPlayType5zu60: {
            [self generateRandomNumberWithCountArray:@[@1,@3]];
            break;
        }
        case LotteryPlayType5zu30: {
            [self generateRandomNumberWithCountArray:@[@2,@1]];
            break;
        }
        case LotteryPlayType5zu20: {
            [self generateRandomNumberWithCountArray:@[@1,@2]];
            break;
        }
        case LotteryPlayType5zu10:
        case LotteryPlayType5zu5:
        case LotteryPlayType4zhi: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayType4zu24: {
            [self generateRandomNumberWithCount:4];
            break;
        }
        case LotteryPlayType4zu12: {
            [self generateRandomNumberWithCountArray:@[@1,@2]];
            break;
        }
        case LotteryPlayTypeQ3zhi: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayTypeQ3zu3: {
            [self generateRandomNumberWithCount:2];
            break;
        }
        case LotteryPlayTypeQ3zu6: {
            [self generateRandomNumberWithCount:3];
            break;
        }
        case LotteryPlayTypeQ3zuHe:
        case LotteryPlayTypeQ3zuBD: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayTypeH3zhiF: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayTypeH3zhiK: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayTypeH3zu3: {
            [self generateRandomNumberWithCount:2];
            break;
        }
        case LotteryPlayTypeH3zu6: {
            [self generateRandomNumberWithCount:3];
            break;
        }
        case LotteryPlayTypeH3zuHe: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayTypeH3zuBD: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayType2zhiH2: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayType2zhiH2He: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayType2zhiH2K: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayType2zhiQ2: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayType2zhiQ2K: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayType2zuH2: {
            [self generateRandomNumberWithCount:2];
            break;
        }
        case LotteryPlayType2zuQ2: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayTypeDWD: {
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i < 4; i++) {
                [array addObject:@0];
            }
            [array insertObject:@1 atIndex:arc4random()%5];
            [self generateRandomNumberWithCountArray:array];
            break;
        }
        case LotteryPlayType3BDWH31: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayType3BDWH32: {
            [self generateRandomNumberWithCount:2];
            break;
        }
        case LotteryPlayType3BDWQ31: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayType3BDWQ32: {
            [self generateRandomNumberWithCount:2];
            break;
        }
        case LotteryPlayType4BDW2: {
            [self generateRandomNumberWithCount:2];
            break;
        }
        case LotteryPlayType5BDW2: {
            [self generateRandomNumberWithCount:2];
            break;
        }
        case LotteryPlayType5BDW3: {
            [self generateRandomNumberWithCount:3];
            break;
        }
        case LotteryPlayTypeT1: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayTypeTH: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayTypeT3: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        case LotteryPlayTypeT4: {
            [self generateRandomNumberWithCount:1];
            break;
        }
        default: {
            break;
        }
    }
    
    [self.tableView reloadData];
}

- (void)generateRandomNumberWithCount:(NSUInteger)count {
    [self.datas enumerateObjectsUsingBlock:^(NumberCellNode *node, NSUInteger idx, BOOL *stop) {
        [node.numbersSet removeAllObjects];
        NSUInteger i = 0;
        while (i < count) {
            [node.numbersSet addObject:@(arc4random()%10)];
            i = node.numbersSet.count;
        }
    }];
}

- (void)generateRandomNumberWithCountArray:(NSArray *)countArray {
    [self.datas enumerateObjectsUsingBlock:^(NumberCellNode *node, NSUInteger idx, BOOL *stop) {
        [node.numbersSet removeAllObjects];
        NSUInteger i = 0;
        NSUInteger count = idx < countArray.count ? [countArray[idx] integerValue]:0;
        while (i < count) {
            [node.numbersSet addObject:@(arc4random()%10)];
            i = node.numbersSet.count;
        }
    }];
}

- (BuyingDropMenuViewController *)dropMenu {
    if (!_dropMenu) {
        BuyingDropMenuViewController *dropMenu = [[BuyingDropMenuViewController alloc] initWithNibName:@"BuyingDropMenuViewController" bundle:nil];
        dropMenu.delegate = self;
        _dropMenu = dropMenu;
    }
    return _dropMenu;
}

- (void)showDropMenu {
    CGRect startFrame = [self.topContainerView convertRect:self.topRightArrowMenuButton.frame toView:self.view];
    
    CGRect frame = CGRectMake(0, CGRectGetMaxY(startFrame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)- CGRectGetMaxY(startFrame));
    
    [self.dropMenu showDropMenuInViewController:self frame:frame completion:^{
        self.dropMenuIsShowed = YES;
    }];
}

- (void)dismissDropMenu {
    
    [self.dropMenu dismissDropMenuCompletion:^{
        self.dropMenuIsShowed = NO;
    }];
}

- (void)checkIsCanBuy {
    NSMutableArray *numbersArray = [NSMutableArray array];
    __block NSUInteger selectCount = 1;
    switch (self.selectedOption.type) {
        case LotteryPlayType5zhi: {
            [self.datas enumerateObjectsUsingBlock:^(NumberCellNode *node, NSUInteger idx, BOOL *stop) {
                [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
                selectCount = selectCount*node.numbersSet.count;
            }];
           
            break;
        }
        case LotteryPlayType5zu120: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = Permutation(node.numbersSet.count, 5);
            break;
        }
        case LotteryPlayType5zu60: {
            if (self.datas.count == 2) {
                NumberCellNode *node1 = [self.datas firstObject];
                NumberCellNode *node2 = self.datas[1];
                NSMutableOrderedSet *set1 = [node1.numbersSet mutableCopy];
                NSMutableOrderedSet *set2 = [node2.numbersSet mutableCopy];
                [numbersArray addObject:[set1.array componentsJoinedByString:@""]];
                [numbersArray addObject:[set2.array componentsJoinedByString:@""]];
                [set1 minusOrderedSet:set2];
                NSUInteger count1 = set1.count;
                NSUInteger count2 = Permutation(set2.count, 3);
                selectCount = count1*count2;
            }
            break;
        }
        case LotteryPlayType5zu30: {
            if (self.datas.count == 2) {
                NumberCellNode *node1 = [self.datas firstObject];
                NumberCellNode *node2 = self.datas[1];
                NSMutableOrderedSet *set1 = [node1.numbersSet mutableCopy];
                NSMutableOrderedSet *set2 = [node2.numbersSet mutableCopy];
                [numbersArray addObject:[set1.array componentsJoinedByString:@""]];
                [numbersArray addObject:[set2.array componentsJoinedByString:@""]];
                NSUInteger count1 = Permutation(set1.count, 2);
                [set2 minusOrderedSet:set1];
                NSUInteger count2 = set2.count;
                selectCount = count1*count2;
            }
            break;
        }
        case LotteryPlayType5zu20: {
            if (self.datas.count == 2) {
                NumberCellNode *node1 = [self.datas firstObject];
                NumberCellNode *node2 = self.datas[1];
                NSMutableOrderedSet *set1 = [node1.numbersSet mutableCopy];
                NSMutableOrderedSet *set2 = [node2.numbersSet mutableCopy];
                [numbersArray addObject:[set1.array componentsJoinedByString:@""]];
                [numbersArray addObject:[set2.array componentsJoinedByString:@""]];
                [set1 minusOrderedSet:set2];
                NSUInteger count1 = set1.count;
                NSUInteger count2 = Permutation(set2.count, 2);
                selectCount = count1*count2;
            }
            
            break;
        }
        case LotteryPlayType5zu10:
        case LotteryPlayType5zu5: {
            if (self.datas.count == 2) {
                NumberCellNode *node1 = [self.datas firstObject];
                NumberCellNode *node2 = self.datas[1];
                NSMutableOrderedSet *set1 = [node1.numbersSet mutableCopy];
                NSMutableOrderedSet *set2 = [node2.numbersSet mutableCopy];
                [numbersArray addObject:[set1.array componentsJoinedByString:@""]];
                [numbersArray addObject:[set2.array componentsJoinedByString:@""]];
                NSUInteger count1 = set1.count;
                NSUInteger count2 = set2.count;
                [set1 intersectOrderedSet:set2];
                selectCount = count1*count2 - set1.count;
            }

            break;
        }
        case LotteryPlayType4zhi: {
            [self.datas enumerateObjectsUsingBlock:^(NumberCellNode *node, NSUInteger idx, BOOL *stop) {
                [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
                selectCount = selectCount*node.numbersSet.count;
            }];

            break;
        }
        case LotteryPlayType4zu24: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = Permutation(node.numbersSet.count, 4);

            break;
        }
        case LotteryPlayType4zu12: {
            if (self.datas.count == 2) {
                NumberCellNode *node1 = [self.datas firstObject];
                NumberCellNode *node2 = self.datas[1];
                NSMutableOrderedSet *set1 = [node1.numbersSet mutableCopy];
                NSMutableOrderedSet *set2 = [node2.numbersSet mutableCopy];
                [numbersArray addObject:[set1.array componentsJoinedByString:@""]];
                [numbersArray addObject:[set2.array componentsJoinedByString:@""]];
                [set1 minusOrderedSet:set2];
                NSUInteger count1 = set1.count;
                NSUInteger count2 = Permutation(set2.count, 2);
                selectCount = count1*count2;
            }

            break;
        }
        case LotteryPlayTypeQ3zhi: {
            [self.datas enumerateObjectsUsingBlock:^(NumberCellNode *node, NSUInteger idx, BOOL *stop) {
                [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
                selectCount = selectCount*node.numbersSet.count;
            }];

            break;
        }
        case LotteryPlayTypeQ3zu3: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = Permutation(node.numbersSet.count, 2);

            break;
        }
        case LotteryPlayTypeQ3zu6: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = Permutation(node.numbersSet.count, 4);

            break;
        }
//        case LotteryPlayTypeQ3zuHe: {
//            NumberCellNode *node = [self.datas firstObject];
//            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
//            selectCount = Permutation(node.numbersSet.count, 1);
//
//            break;
//        }
        case LotteryPlayTypeQ3zuBD: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = 54;
            break;
        }
        case LotteryPlayTypeH3zhiF: {
            [self.datas enumerateObjectsUsingBlock:^(NumberCellNode *node, NSUInteger idx, BOOL *stop) {
                [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
                selectCount = selectCount*node.numbersSet.count;
            }];

            break;
        }
//        case LotteryPlayTypeH3zhiK: {
//            <#statement#>
//            break;
//        }
        case LotteryPlayTypeH3zu3: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = 2*Permutation(node.numbersSet.count, 2);

            break;
        }
        case LotteryPlayTypeH3zu6: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = Permutation(node.numbersSet.count, 3);

            break;
        }
//        case LotteryPlayTypeH3zuHe: {
//            <#statement#>
//            break;
//        }
//        case LotteryPlayTypeH3zuBD: {
//            <#statement#>
//            break;
//        }
        case LotteryPlayType2zhiH2: {
            [self.datas enumerateObjectsUsingBlock:^(NumberCellNode *node, NSUInteger idx, BOOL *stop) {
                [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
                selectCount = selectCount*node.numbersSet.count;
            }];

            break;
        }
//        case LotteryPlayType2zhiH2He: {
//            <#statement#>
//            break;
//        }
//        case LotteryPlayType2zhiH2K: {
//            <#statement#>
//            break;
//        }
        case LotteryPlayType2zhiQ2: {
            [self.datas enumerateObjectsUsingBlock:^(NumberCellNode *node, NSUInteger idx, BOOL *stop) {
                [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
                selectCount = selectCount*node.numbersSet.count;
            }];

            break;
        }
//        case LotteryPlayType2zhiQ2K: {
//            <#statement#>
//            break;
//        }
        case LotteryPlayType2zuH2: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = Permutation(node.numbersSet.count, 2);

            break;
        }
        case LotteryPlayType2zuQ2: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = Permutation(node.numbersSet.count, 3);

            break;
        }
        case LotteryPlayTypeDWD: {
            selectCount = 0;
            [self.datas enumerateObjectsUsingBlock:^(NumberCellNode *node, NSUInteger idx, BOOL *stop) {
                [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
                selectCount = selectCount + node.numbersSet.count;
            }];

            break;
        }
        case LotteryPlayType3BDWH31: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = node.numbersSet.count;

            break;
        }
        case LotteryPlayType3BDWH32: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = Permutation(node.numbersSet.count, 2);

            break;
        }
        case LotteryPlayType3BDWQ31: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = node.numbersSet.count;

            break;
        }
        case LotteryPlayType3BDWQ32: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = Permutation(node.numbersSet.count, 2);

            break;
        }
        case LotteryPlayType4BDW2: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = Permutation(node.numbersSet.count, 2);

            break;
        }
        case LotteryPlayType5BDW2: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = Permutation(node.numbersSet.count, 2);

            break;
        }
        case LotteryPlayType5BDW3: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = Permutation(node.numbersSet.count, 3);

            break;
        }
        case LotteryPlayTypeT1:
        case LotteryPlayTypeTH:
        case LotteryPlayTypeT3:
        case LotteryPlayTypeT4: {
            NumberCellNode *node = [self.datas firstObject];
            [numbersArray addObject:[node.numbersSet.array componentsJoinedByString:@""]];
            selectCount = node.numbersSet.count;
            break;
        }
        default: {
            break;
        }
    }
    
    NSString *selectNumberString = [numbersArray componentsJoinedByString:@","];

    BOOL canBuy = selectCount > 0? YES:NO;
    self.canBuyLottery = canBuy;
    self.bottomBar.canBuyLottery = canBuy;
    
    self.bottomBar.topLabel.text = [NSString stringWithFormat:@"已选%ld注，%.2f元",selectCount,selectCount*0.2];
    self.bottomBar.bottomLabel.text = selectNumberString;
}

#pragma mark - custom event methods

- (void)infoButtonClicked:(id)sender {

}

- (void)topRightArrowMenuButtonClicked:(id)sender {
    if (!self.dropMenuIsShowed) {
        [self showDropMenu];
    }else{
        [self dismissDropMenu];
    }
}

- (void)shakeButtonClicked:(id)sender {
    [self randomSelectNumbers];
    [self checkIsCanBuy];
}

#pragma mark - BuyingDropMenuViewControllerDelegate methods

- (void)dropMenuController:(BuyingDropMenuViewController *)controller didSelectMenuItemAtIndexPath:(NSIndexPath *)indexPath option:(LotteryPlayOption *)option {
    [self dismissDropMenu];
    NSString *title = lotteryPlayTypeString[option.type];
    [self.CurrentSelectMenuList insertTagWithTitle:title atIndex:0 selected:YES];
    
    //
    self.selectedOption = option;
    [self buildDataWithOption:self.selectedOption];
    [self.tableView reloadData];
}

#pragma mark - ARTagListViewDelegate methods

- (void)tagListView:(ARTagListView *)tagListView didSelectTagAtIndex:(NSUInteger)index title:(NSString *)title {
    NSLog(@"select title is %@",title);
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectNumbersCell *numberCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    numberCell.delegate = self;
    NumberCellNode *node = self.datas[indexPath.row];
    [numberCell fillCellWithNode:node];

    return numberCell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NumberCellNode *node = self.datas[indexPath.row];
    if (node.cellType == NumberCellTypeDefault || node.cellType == NumberCellTypeBaoDan) {
        return 126;
    }
    return 240;
}

#pragma mark - SelectNumbersCellDelegate methods

-(void)numbersCell:(SelectNumbersCell *)numbersCell seletedNumber:(NSInteger)selectedNumber isSelected:(BOOL)isSelected
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:numbersCell];
    NSNumber *indexString = @(selectedNumber);
    NumberCellNode *node = self.datas[indexPath.row];
    NSMutableOrderedSet *orderSet = node.numbersSet;
    if (node.cellType == NumberCellTypeBaoDan) {
        [orderSet removeAllObjects];
    }
    if (isSelected) {
        [orderSet addObject:indexString];
    }else{
        [orderSet removeObject:indexString];
    }
    
    [self checkIsCanBuy];
}

-(void)numbersCell:(SelectNumbersCell *)numbersCell segmentTitle:(OAStackView *)segmentTitle selectIndex:(NSUInteger)selectIndex {

    NSIndexPath *indexPath = [self.tableView indexPathForCell:numbersCell];
    NSUInteger row = indexPath.row;
    NumberCellNode *node = self.datas[row];
    NSMutableOrderedSet *numberSet = [NSMutableOrderedSet orderedSet];
    switch (selectIndex) {
        case 0:{
            NSUInteger count = numbersCell.gridView.items.count/2;
            NSUInteger start = [numbersCell.gridView.items.lastObject index];
            for (NSUInteger i = 0; i < count; i++) {
                [numberSet addObject:@(start - i)];
            }
            break;
        }
        case 1:{
            NSUInteger count = numbersCell.gridView.items.count/2;
            NSUInteger start = [numbersCell.gridView.items.firstObject index];
            for (NSUInteger i = 0; i < count; i++) {
                [numberSet addObject:@(start + i)];
            }
            break;
        }
        case 2:{
            NSUInteger count = numbersCell.gridView.items.count;
            NSUInteger start = [numbersCell.gridView.items.firstObject index];
            for (NSUInteger i = 0; i < count; i++) {
                [numberSet addObject:@(start + i)];
            }
            break;
        }
        case 3:{
            NSUInteger count = numbersCell.gridView.items.count;
            NSUInteger start = node.cellType == NumberCellTypeHeZhi ? 1:0;
            for (NSUInteger i = 0; i < count; i++) {
                if (i%2 == 1) {
                    [numberSet addObject:@(i - start)];
                }
            }
            break;
        }
        case 4:{
            NSUInteger count = numbersCell.gridView.items.count;
            NSUInteger start = node.cellType == NumberCellTypeHeZhi ? 1:0;
            for (NSUInteger i = 0; i < count; i++) {
                if (i%2 == 0) {
                    [numberSet addObject:@(i + start)];
                }
            }


            break;
        }
        case 5:{
            break;
        }
            
        default:
            break;
    }

    node.numbersSet = numberSet;
    node.segmentSelectIndex = selectIndex;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self checkIsCanBuy];
}

#pragma mark - motion delegate methods

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self randomSelectNumbers];
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{}

-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{}

#pragma mark - manage memory methods

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
