//
//  AnnouncementVC.m
//  Lottery
//
//  Created by 刘继洋 on 15/7/13.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "AnnouncementVC.h"

@interface AnnouncementVC ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  列表容器
 */
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;
/**
 *  公告
 */
@property (weak, nonatomic) IBOutlet UITableView *announcementTable;
/**
 *  站内信
 */
@property (weak, nonatomic) IBOutlet UITableView *insideLetterTable;

@end

@implementation AnnouncementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.announcementTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.insideLetterTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"lcell"];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  点击segment
 *
 *  @param sender segmentcontrol
 */
- (IBAction)selectedControl:(UISegmentedControl *)sender {
    
    NSInteger index = sender.selectedSegmentIndex;
    if (index == 0) {
        [self.backScrollView scrollRectToVisible:self.view.frame animated:YES];
    }else{
        [self.backScrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width  , 200, self.view.frame.size.width, 200) animated:YES];
    }
}


#pragma mark -- <UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (tableView == self.insideLetterTable) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"lcell"];
    }
    cell.textLabel.text = @"test";
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.;
}


@end
