//
//  BuyingDropMenuViewController.m
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "BuyingDropMenuViewController.h"
#import "DropMenuCell.h"

@interface BuyingDropMenuViewController ()

@property (nonatomic, strong) NSMutableArray *menuDatas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@end

@implementation BuyingDropMenuViewController

#pragma mark - lifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

- (void)setUp {
    [self.tableView registerNib:[UINib nibWithNibName:@"DropMenuCell" bundle:nil] forCellReuseIdentifier:@"DropMenuCell"];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
}

#pragma mark - public methods

- (void)expandTableView {
    self.tableViewHeightConstraint.constant = 250;
    [self.view setNeedsLayout];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

- (void)closeTableView {
    self.tableViewHeightConstraint.constant = 0;
    [self.view setNeedsLayout];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
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
    return self.menuDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DropMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropMenuCell" forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
