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

@interface BuyingViewController ()<UITableViewDelegate,UITableViewDataSource,SelectNumbersCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *titles;

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
    self.titles = [NSMutableArray arrayWithObjects:@"万",@"千",@"百",@"十",@"个", nil];
    //5 行
    for (int i = 0; i < 5; i++) {
        [self.datas addObject:[NSMutableOrderedSet orderedSet]];
    }
    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

-(void)randomSelectNumbers
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [self.datas enumerateObjectsUsingBlock:^(NSMutableOrderedSet *set, NSUInteger idx, BOOL *stop) {
        [set removeAllObjects];
        NSUInteger randomNumber = arc4random()%10;
        [set addObject:@(randomNumber)];
    }];
    
    [self.tableView reloadData];
}

#pragma mark - custom event methods

-(void)infoButtonClicked:(id)sender
{

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
    [numberCell fillCellWithNumbersSet:self.datas[indexPath.row] title:self.titles[indexPath.row]];

    return numberCell;
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 146;
}

#pragma mark - SelectNumbersCellDelegate methods

-(void)numbersCell:(SelectNumbersCell *)numbersCell seletedNumber:(NSInteger)selectedNumber isSelected:(BOOL)isSelected
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:numbersCell];
    NSString *indexString = [NSString stringWithFormat:@"%ld",selectedNumber];
    NSMutableOrderedSet *orderSet = self.datas[indexPath.row];
    if (isSelected) {
        [orderSet addObject:indexString];
    }else{
        [orderSet removeObject:indexString];
    }
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
