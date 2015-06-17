//
//  CustomDropDownView.h
//  Lottery
//
//  Created by 刘继洋 on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDropDownView : UIView<UITableViewDataSource,UITableViewDelegate>

/**
 *  列表
 */
@property (nonatomic,strong) UITableView *listView;
/**
 *  数据源
 */
@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,copy) void(^selectedData)(NSDictionary *selectedData);
/**
 *  初始化
 *
 *  @param frame
 *
 *  @return 
 */
- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray*)dataArray;

/**
 *  消失
 *
 *  @param cellIndex
 */

- (void)dismiss;

@end
