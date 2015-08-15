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
//        case LotteryPlayTypeQ3zuHe: {
//            <#statement#>
//            break;
//        }
        case LotteryPlayTypeQ3zuBD: {
            [self addNodesWithTitles:@[@"选"]];
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
//        case LotteryPlayTypeH3zuHe: {
//            <#statement#>
//            break;
//        }
        case LotteryPlayTypeH3zuBD: {
            [self addNodesWithTitles:@[@"选"]];
            break;
        }
        case LotteryPlayType2zhiH2: {
            [self addNodesWithTitles:@[@"十",@"个"]];
            break;
        }
//        case LotteryPlayType2zhiH2He: {
//            <#statement#>
//            break;
//        }
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
    for (int i = 0; i < titles.count; i++) {
        NumberCellNode *node = [[NumberCellNode alloc] init];
        node.title = titles[i];
        [self.datas addObject:node];
    }
}

-(void)randomSelectNumbers
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [self.datas enumerateObjectsUsingBlock:^(NumberCellNode *node, NSUInteger idx, BOOL *stop) {
        [node.numbersSet removeAllObjects];
        NSUInteger randomNumber = arc4random()%10;
        [node.numbersSet addObject:@(randomNumber)];
    }];
    
    [self.tableView reloadData];
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
    __block BOOL canBuy = YES;
    __block NSUInteger hasSelectLotteryCount = 1;
    __block NSMutableString *selectNumberString = [NSMutableString string];
    [self.datas enumerateObjectsUsingBlock:^(NumberCellNode *node, NSUInteger idx, BOOL *stop) {
        if (node.numbersSet.count == 0) {
            canBuy = NO;
            *stop = YES;
        }
        
        hasSelectLotteryCount = hasSelectLotteryCount*node.numbersSet.count;
        [selectNumberString appendString:[node.numbersSet.array componentsJoinedByString:@""]];
        [selectNumberString appendString:@","];
    }];
    
    self.canBuyLottery = canBuy;
    self.bottomBar.canBuyLottery = canBuy;
    
    if (canBuy) {
        self.bottomBar.topLabel.text = [NSString stringWithFormat:@"已选%ld注，%2f元",hasSelectLotteryCount,hasSelectLotteryCount*0.2];
        
        self.bottomBar.bottomLabel.text = selectNumberString;
    }
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectNumbersCell *numberCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    numberCell.delegate = self;
    [numberCell fillCellWithNode:self.datas[indexPath.row]];

    return numberCell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 156;
}

#pragma mark - SelectNumbersCellDelegate methods

-(void)numbersCell:(SelectNumbersCell *)numbersCell seletedNumber:(NSInteger)selectedNumber isSelected:(BOOL)isSelected
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:numbersCell];
    NSString *indexString = [NSString stringWithFormat:@"%ld",(long)selectedNumber];
    NumberCellNode *node = self.datas[indexPath.row];
    NSMutableOrderedSet *orderSet = node.numbersSet;
    if (isSelected) {
        [orderSet addObject:indexString];
    }else{
        [orderSet removeObject:indexString];
    }
    
    [self checkIsCanBuy];
}

-(void)numbersCell:(SelectNumbersCell *)numbersCell segmentTitle:(OAStackView *)segmentTitle selectIndex:(NSUInteger)selectIndex
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:numbersCell];
    NSUInteger row = indexPath.row;
    NSMutableOrderedSet *numberSet = [NSMutableOrderedSet orderedSet];
    switch (selectIndex) {
        case 0:{
            [numberSet addObjectsFromArray:@[@(5),@(6),@(7),@(8),@(9)]];
            break;
        }
        case 1:{
            [numberSet addObjectsFromArray:@[@(0),@(1),@(2),@(3),@(4)]];
            break;
        }
        case 2:{
            NSArray *numbers = @[@(0),@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9)];
            [numberSet addObjectsFromArray:numbers];
            break;
        }
        case 3:{
            NSArray *numbers = @[@(1),@(3),@(5),@(7),@(9)];
            [numberSet addObjectsFromArray:numbers];
            break;
        }
        case 4:{
            NSArray *numbers = @[@(0),@(2),@(4),@(6),@(8)];
            [numberSet addObjectsFromArray:numbers];

            break;
        }
        case 5:{
            break;
        }
            
        default:
            break;
    }
    NumberCellNode *node = self.datas[row];
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
