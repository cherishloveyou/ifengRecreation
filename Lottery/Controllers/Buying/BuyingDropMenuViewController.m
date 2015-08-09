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
    DropMenuNode *node1 = [[DropMenuNode alloc] initWithTitle:@"五星直选" options:@[@"复式"]];
    DropMenuNode *node2 = [[DropMenuNode alloc] initWithTitle:@"五星组选" options:@[@"组选120",@"组选60",@"组选30",@"组选20",@"组选10",@"组选5"]];
    DropMenuNode *node3 = [[DropMenuNode alloc] initWithTitle:@"四星直选" options:@[@"复式"]];
    DropMenuNode *node4 = [[DropMenuNode alloc] initWithTitle:@"四星组选" options:@[@"组选24",@"组选12"]];
    DropMenuNode *node5 = [[DropMenuNode alloc] initWithTitle:@"前三直选" options:@[@"复式"]];
    DropMenuNode *node6 = [[DropMenuNode alloc] initWithTitle:@"前三组选" options:@[@"组三",@"组六",@"组选合值",@"包胆"]];
    DropMenuNode *node7 = [[DropMenuNode alloc] initWithTitle:@"后三直选" options:@[@"复式",@"跨度"]];
    DropMenuNode *node8 = [[DropMenuNode alloc] initWithTitle:@"后三组选" options:@[@"组三",@"组六",@"组选合值",@"包胆"]];
    DropMenuNode *node9 = [[DropMenuNode alloc] initWithTitle:@"二星直选" options:@[@"后二(复式)",@"后二合值",@"后二跨度",@"前二(复式)",@"前二跨度"]];
    DropMenuNode *node10 = [[DropMenuNode alloc] initWithTitle:@"二星组选" options:@[@"后二(复式)",@"前二(复式)"]];
    DropMenuNode *node11 = [[DropMenuNode alloc] initWithTitle:@"定位胆" options:@[@"定位胆"]];
    DropMenuNode *node12 = [[DropMenuNode alloc] initWithTitle:@"三星不定位" options:@[@"后三一码不定位",@"后三二码不定位",@"前三一码不定位",@"前三二码不定位"]];
    DropMenuNode *node13 = [[DropMenuNode alloc] initWithTitle:@"四星不定位" options:@[@"四星二码不定位"]];
    DropMenuNode *node14 = [[DropMenuNode alloc] initWithTitle:@"五星不定位" options:@[@"五星二码不定位",@"五星三码不定位"]];
    DropMenuNode *node15 = [[DropMenuNode alloc] initWithTitle:@"特殊" options:@[@"一帆风顺",@"好事成双",@"三星报喜",@"四季发财"]];
    
    [self.menuNodes addObjectsFromArray:@[node1,node2,node3,node4,node5,node6,node7,node8,node9,node10,node11,node12,node13,node14,node15]];
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

- (void)dropMenuCell:(DropMenuCell *)cell didSelectedItemAtIndex:(NSUInteger)index title:(NSString *)title {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:index inSection:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(dropMenuController:didSelectMenuItemAtIndexPath:title:)]) {
        [self.delegate dropMenuController:self didSelectMenuItemAtIndexPath:newIndexPath title:title];
    }
}

@end
