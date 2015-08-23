//
//  BuyingDropMenuViewController.m
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "BuyingDropMenuViewController.h"
#import "DropMenuCell.h"
#import "DropMenuNode.h"
#import "ARBasicAnimation.h"

NSString *const TouchBackgroundNotification = @"TouchBackgroundNotification";

@interface BuyingDropMenuViewController ()<UITableViewDelegate,UITableViewDataSource,DropMenuCellDelegate>

@property (nonatomic, strong) NSMutableArray *menuNodes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation BuyingDropMenuViewController

#pragma mark - lifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

- (void)dealloc {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

- (void)setUp {
    self.maskLayer = [CAShapeLayer layer];
    self.maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    self.menuNodes = [NSMutableArray array];
    
    if (self.lotteryType == LotteryTypeChongQingShiShiCai) {
        LotteryPlayOption *op1 = [LotteryPlayOption optionWithType:LotteryPlayType5zhi];
        DropMenuNode *node1 = [[DropMenuNode alloc] initWithTitle:@"五星直选" options:@[op1]];
        
        LotteryPlayOption *op2 = [LotteryPlayOption optionWithType:LotteryPlayType5zu120];
        LotteryPlayOption *op3 = [LotteryPlayOption optionWithType:LotteryPlayType5zu60];
        LotteryPlayOption *op4 = [LotteryPlayOption optionWithType:LotteryPlayType5zu30];
        LotteryPlayOption *op5 = [LotteryPlayOption optionWithType:LotteryPlayType5zu20];
        LotteryPlayOption *op6 = [LotteryPlayOption optionWithType:LotteryPlayType5zu10];
        LotteryPlayOption *op7 = [LotteryPlayOption optionWithType:LotteryPlayType5zu5];
        DropMenuNode *node2 = [[DropMenuNode alloc] initWithTitle:@"五星组选" options:@[op2,op3,op4,op5,op6,op7]];
        
        LotteryPlayOption *op8 = [LotteryPlayOption optionWithType:LotteryPlayType4zhi];
        DropMenuNode *node3 = [[DropMenuNode alloc] initWithTitle:@"四星直选" options:@[op8]];
        
        LotteryPlayOption *op9 = [LotteryPlayOption optionWithType:LotteryPlayType4zu24];
        LotteryPlayOption *op10 = [LotteryPlayOption optionWithType:LotteryPlayType4zu12];
        DropMenuNode *node4 = [[DropMenuNode alloc] initWithTitle:@"四星组选" options:@[op9,op10]];
        
        LotteryPlayOption *op11 = [LotteryPlayOption optionWithType:LotteryPlayTypeQ3zhi];
        DropMenuNode *node5 = [[DropMenuNode alloc] initWithTitle:@"前三直选" options:@[op11]];
        
        LotteryPlayOption *op12 = [LotteryPlayOption optionWithType:LotteryPlayTypeQ3zu3];
        LotteryPlayOption *op13 = [LotteryPlayOption optionWithType:LotteryPlayTypeQ3zu6];
        LotteryPlayOption *op14 = [LotteryPlayOption optionWithType:LotteryPlayTypeQ3zuHe];
        LotteryPlayOption *op15 = [LotteryPlayOption optionWithType:LotteryPlayTypeQ3zuBD];
        DropMenuNode *node6 = [[DropMenuNode alloc] initWithTitle:@"前三组选" options:@[op12,op13,op14,op15]];
        
        LotteryPlayOption *op16 = [LotteryPlayOption optionWithType:LotteryPlayTypeH3zhiF];
        LotteryPlayOption *op17 = [LotteryPlayOption optionWithType:LotteryPlayTypeH3zhiK];
        DropMenuNode *node7 = [[DropMenuNode alloc] initWithTitle:@"后三直选" options:@[op16,op17]];
        
        LotteryPlayOption *op18 = [LotteryPlayOption optionWithType:LotteryPlayTypeH3zu3];
        LotteryPlayOption *op19 = [LotteryPlayOption optionWithType:LotteryPlayTypeH3zu6];
        LotteryPlayOption *op20 = [LotteryPlayOption optionWithType:LotteryPlayTypeH3zuHe];
        LotteryPlayOption *op21 = [LotteryPlayOption optionWithType:LotteryPlayTypeH3zuBD];
        DropMenuNode *node8 = [[DropMenuNode alloc] initWithTitle:@"后三组选" options:@[op18,op19,op20,op21]];
        
        LotteryPlayOption *op22 = [LotteryPlayOption optionWithType:LotteryPlayType2zhiH2];
        LotteryPlayOption *op23 = [LotteryPlayOption optionWithType:LotteryPlayType2zhiH2He];
        LotteryPlayOption *op24 = [LotteryPlayOption optionWithType:LotteryPlayType2zhiH2K];
        LotteryPlayOption *op25 = [LotteryPlayOption optionWithType:LotteryPlayType2zhiQ2];
        LotteryPlayOption *op26 = [LotteryPlayOption optionWithType:LotteryPlayType2zhiQ2K];
        DropMenuNode *node9 = [[DropMenuNode alloc] initWithTitle:@"二星直选" options:@[op22,op23,op24,op25,op26]];
        
        LotteryPlayOption *op27 = [LotteryPlayOption optionWithType:LotteryPlayType2zuH2];
        LotteryPlayOption *op28 = [LotteryPlayOption optionWithType:LotteryPlayType2zuQ2];
        DropMenuNode *node10 = [[DropMenuNode alloc] initWithTitle:@"二星组选" options:@[op27,op28]];
        
        LotteryPlayOption *op29 = [LotteryPlayOption optionWithType:LotteryPlayTypeDWD];
        DropMenuNode *node11 = [[DropMenuNode alloc] initWithTitle:@"定位胆" options:@[op29]];
        
        LotteryPlayOption *op30 = [LotteryPlayOption optionWithType:LotteryPlayType3BDWH31];
        LotteryPlayOption *op31 = [LotteryPlayOption optionWithType:LotteryPlayType3BDWH32];
        LotteryPlayOption *op32 = [LotteryPlayOption optionWithType:LotteryPlayType3BDWQ31];
        LotteryPlayOption *op33 = [LotteryPlayOption optionWithType:LotteryPlayType3BDWQ32];
        DropMenuNode *node12 = [[DropMenuNode alloc] initWithTitle:@"三星不定位" options:@[op30,op31,op32,op33]];
        
        LotteryPlayOption *op34 = [LotteryPlayOption optionWithType:LotteryPlayType4BDW2];
        DropMenuNode *node13 = [[DropMenuNode alloc] initWithTitle:@"四星不定位" options:@[op34]];
        
        LotteryPlayOption *op35 = [LotteryPlayOption optionWithType:LotteryPlayType5BDW2];
        LotteryPlayOption *op36 = [LotteryPlayOption optionWithType:LotteryPlayType5BDW3];
        DropMenuNode *node14 = [[DropMenuNode alloc] initWithTitle:@"五星不定位" options:@[op35,op36]];
        
        LotteryPlayOption *op37 = [LotteryPlayOption optionWithType:LotteryPlayTypeT1];
        LotteryPlayOption *op38 = [LotteryPlayOption optionWithType:LotteryPlayTypeTH];
        LotteryPlayOption *op39 = [LotteryPlayOption optionWithType:LotteryPlayTypeT3];
        LotteryPlayOption *op40 = [LotteryPlayOption optionWithType:LotteryPlayTypeT4];
        
        DropMenuNode *node15 = [[DropMenuNode alloc] initWithTitle:@"特殊" options:@[op37,op38,op39,op40]];
        
        [self.menuNodes addObjectsFromArray:@[node1,node2,node3,node4,node5,node6,node7,node8,node9,node10,node11,node12,node13,node14,node15]];
    }else if (self.lotteryType == LotteryTypeShandongShiYiXuanWu){

        LotteryPlayOption *op1 = [LotteryPlayOption optionWithType:LotteryPlayTypeSDQ3ZF];
        LotteryPlayOption *op2 = [LotteryPlayOption optionWithType:LotteryPlayTypeSDQ3ZuF];
        DropMenuNode *node1 = [[DropMenuNode alloc] initWithTitle:@"三码" options:@[op1,op2]];
        
        LotteryPlayOption *op3 = [LotteryPlayOption optionWithType:LotteryPlayTypeSDDWD];
        DropMenuNode *node2 = [[DropMenuNode alloc] initWithTitle:@"定位胆" options:@[op3]];
        
        LotteryPlayOption *op4 = [LotteryPlayOption optionWithType:LotteryPlayTypeRXF11];
        LotteryPlayOption *op5 = [LotteryPlayOption optionWithType:LotteryPlayTypeRXF22];
        LotteryPlayOption *op6 = [LotteryPlayOption optionWithType:LotteryPlayTypeRXF33];
        LotteryPlayOption *op7 = [LotteryPlayOption optionWithType:LotteryPlayTypeRXF44];
        LotteryPlayOption *op8 = [LotteryPlayOption optionWithType:LotteryPlayTypeRXF55];
        DropMenuNode *node3 = [[DropMenuNode alloc] initWithTitle:@"任选复式" options:@[op4,op5,op6,op7,op8]];
        
        LotteryPlayOption *op9 = [LotteryPlayOption optionWithType:LotteryPlayTypeDT55];
        DropMenuNode *node4 = [[DropMenuNode alloc] initWithTitle:@"任选胆托" options:@[op9]];
        
        [self.menuNodes addObjectsFromArray:@[node1,node2,node3,node4]];
    }

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TouchBackgroundNotification object:nil];
}

#pragma mark - public methods

- (void)expandTableView {
    self.tableView.layer.mask = self.maskLayer;
    ARBasicAnimation *basicAnimation = [ARBasicAnimation animationWithKeyPath:@"path"];
    UIBezierPath *toValue = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    basicAnimation.duration = 0.5;
    basicAnimation.removedOnCompletion = YES;
    basicAnimation.fromValue = (id)[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0)].CGPath;
    basicAnimation.toValue = (id)toValue.CGPath;
    //fix UITableViewWrapperView bug, unknow reason
    [basicAnimation setCompletion:^(BOOL finished) {
        self.tableView.layer.mask = nil;
    }];
    self.maskLayer.path = [toValue CGPath];
    [self.maskLayer addAnimation:basicAnimation forKey:@"path"];

}

- (void)closeTableView {
    self.tableView.layer.mask = self.maskLayer;
    ARBasicAnimation *basicAnimation = [ARBasicAnimation animationWithKeyPath:@"path"];
    UIBezierPath *fromValue = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.tableView.bounds))];
    basicAnimation.duration = 0.5;
    basicAnimation.removedOnCompletion = YES;
    basicAnimation.toValue = (id)[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0)].CGPath;
    //fix UITableViewWrapperView bug, unknow reason
    [basicAnimation setCompletion:^(BOOL finished) {
        self.tableView.layer.mask = nil;
    }];
    basicAnimation.fromValue = (id)fromValue.CGPath;
    self.maskLayer.path = [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0)] CGPath];
    [self.maskLayer addAnimation:basicAnimation forKey:@"path1"];
}

- (void)showDropMenuInViewController:(UIViewController *)viewController frame:(CGRect)frame completion:(void (^)(void))completion {

    [self willMoveToParentViewController:viewController];
    [viewController.view addSubview:self.view];
    self.view.frame = frame;
    [viewController addChildViewController:self];
    
    [self expandTableView];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
                     } completion:^(BOOL finished) {
                         [self didMoveToParentViewController:viewController];
                         if (completion) {
                             completion();
                         }
                     }];

}

- (void)dismissDropMenuCompletion:(void (^)(void))completion {
    [self closeTableView];
    [self willMoveToParentViewController:nil];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
                     } completion:^(BOOL finished) {
                         [self.view removeFromSuperview];
                         [self removeFromParentViewController];
                         [self didMoveToParentViewController:nil];
                         if (completion) {
                             completion();
                         }
                     }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuNodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = [NSString stringWithFormat:@"cell %ld",indexPath.row];
    DropMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[DropMenuCell alloc] initWithIndex:indexPath.row reuseIdentifier:reuseIdentifier];
    }
    cell.delegate = self;
    [cell fillCellWithNode:self.menuNodes[indexPath.row]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;
    if (row == 0 || row == 2 || row == 3 || row == 4 || row == 5 || row == 6 || row == 6 || row == 7 || row == 9 || row == 10 || row == 12 || row == 13) {
        return 35;
    }
    return 70;
}

#pragma mark - DropMenuCellDelegate methods

- (void)dropMenuCell:(DropMenuCell *)cell didSelectedOption:(LotteryPlayOption *)option {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if ([self.delegate respondsToSelector:@selector(dropMenuController:didSelectMenuItemAtIndexPath:option:)]) {
        [self.delegate dropMenuController:self didSelectMenuItemAtIndexPath:indexPath option:option];
    }
}

@end
