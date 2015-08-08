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

@interface BuyingViewController ()<UITableViewDelegate,UITableViewDataSource,SelectNumbersCellDelegate,ARTagListViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UIView *topContainerView;
@property (strong, nonatomic) ARTagListView *CurrentSelectMenuList;
@property (strong, nonatomic) UIButton *topRightArrowMenuButton;
@property (strong, nonatomic) UILabel *countdownLabel;
@property (strong, nonatomic) UIButton *shakeButton;

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
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(infoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *infoItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    [self.navigationItem setRightBarButtonItem:infoItem];
    
    self.datas = [NSMutableArray array];
    NSArray *titles = @[@"万",@"千",@"百",@"十",@"个"];
    //5 行
    for (int i = 0; i < titles.count; i++) {
        NumberCellNode *node = [[NumberCellNode alloc] init];
        node.title = titles[i];
        [self.datas addObject:node];
    }
    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    //
    self.CurrentSelectMenuList = [[ARTagListView alloc] init];
    [self.CurrentSelectMenuList.layer setBorderWidth:0.5];
    [self.CurrentSelectMenuList.layer setBorderColor:[UIColor fadedBlueColor].CGColor];
    self.CurrentSelectMenuList.tagListDelegate = self;
    [self.topContainerView addSubview:self.CurrentSelectMenuList];
    //menu button
    [self.CurrentSelectMenuList addTagsWithTitles:@[@"test",@"test2",@"test",@"test2",@"test",@"test2",@"test",@"test2"]];
    
    self.topRightArrowMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.topRightArrowMenuButton setImage:[UIImage imageNamed:@"drop_button"] forState:UIControlStateNormal];
    [self.topRightArrowMenuButton addTarget:self action:@selector(topRightArrowMenuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topRightArrowMenuButton.layer setBorderColor:[UIColor fadedBlueColor].CGColor];
    [self.topRightArrowMenuButton.layer setBorderWidth:0.5];
    [self.topContainerView addSubview:self.topRightArrowMenuButton];
    //
    self.countdownLabel = [[UILabel alloc] init];
    self.countdownLabel.text = @"test";
    self.countdownLabel.font = [UIFont systemFontOfSize:16];
    [self.topContainerView addSubview:self.countdownLabel];
    
    self.shakeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shakeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.shakeButton setTitleColor:[UIColor fadedBlueColor] forState:UIControlStateNormal];
    [self.shakeButton setTitle:@"摇一摇机选" forState:UIControlStateNormal];
    [self.shakeButton setImage:[UIImage imageNamed:@"closse"] forState:UIControlStateNormal];
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

    [self.countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CurrentSelectMenuList.mas_bottom);
        make.left.equalTo(@10);
        make.bottom.equalTo(@0);
    }];
    
    [self.shakeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topRightArrowMenuButton.mas_bottom);
        make.right.equalTo(@-5);
        make.bottom.equalTo(@0);
    }];
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

#pragma mark - custom event methods

- (void)infoButtonClicked:(id)sender {

}

- (void)topRightArrowMenuButtonClicked:(id)sender {

}

- (void)shakeButtonClicked:(id)sender {
    [self randomSelectNumbers];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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

-(void)dealloc
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
