//
//  DropButton.m
//  Lottery
//
//  Created by August on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "DropButton.h"
#import <Masonry.h>

@interface DropButton ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, assign) BOOL hasShowMenu;

@end

@implementation DropButton

-(instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        self.titles = titles;
        
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    self.hasShowMenu = NO;
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.titles[0];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.titleLabel];
    
    self.arrowImageView = [[UIImageView alloc] init];
    self.arrowImageView.image = [UIImage imageNamed:@"drop_button"];
    [self addSubview:self.arrowImageView];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(@0);
        make.right.equalTo(self.arrowImageView.mas_left);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.centerY.equalTo(self);
    }];
    
    [self addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clicked:(id)sender
{
    CGFloat angle = self.hasShowMenu?0:M_PI;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.arrowImageView.layer.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
                     } completion:^(BOOL finished) {
                         self.hasShowMenu = !self.hasShowMenu;
                     }];
}

@end


@implementation DropButtonItem

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(@0);
        make.right.equalTo(self.mas_left);
    }];
}

@end
