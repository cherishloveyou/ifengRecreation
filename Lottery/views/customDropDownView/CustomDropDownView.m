//
//  CustomDropDownView.m
//  Lottery
//
//  Created by 刘继洋 on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "CustomDropDownView.h"
#import "DropDownViewCell.h"

@implementation CustomDropDownView

- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)dataArray{
    self = [super initWithFrame:frame];
    if (self) {
        if (dataArray) {
            self.dataArray = dataArray;
            [self addTableView];
        }
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (UITableView *)listView{
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:self.bounds];
        UIView *footer = [[UIView alloc] init];
        footer.backgroundColor = [UIColor whiteColor];
        
        [_listView setTableFooterView:footer];
        
        
        _listView.delegate = self;
        _listView.dataSource = self;
    }
    return _listView;
}


- (void)addTableView{
   
    [self addSubview:self.listView];
    
}

#pragma mark -- <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    DropDownViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DropDownViewCell" owner:self options:nil] lastObject];
    }
    
    
    cell.midTextLabel.text = [self.dataArray[indexPath.row] allKeys][0];
    
    return cell;
}

#pragma mark -- <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectedData) {
        
        self.selectedData(self.dataArray[indexPath.row]);
    }
    [self dismiss];

}

- (void)dismiss{
    [self removeFromSuperview];
    self.listView = nil;
}



@end
