//
//  DropButton.h
//  Lottery
//
//  Created by August on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropButton : UIControl

@property (nonatomic, strong, readonly) NSArray *titles;

-(instancetype)initWithTitles:(NSArray *)titles;

@end

@interface DropButtonItem : UIControl

@property (nonatomic, strong) UILabel *titleLabel;

@end