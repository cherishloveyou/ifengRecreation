//
//  DropButton.m
//  Lottery
//
//  Created by August on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "DropButton.h"
#import <Masonry.h>
#import "OAStackView.h"

@interface DropButton ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, assign) BOOL hasShowMenu;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) OAStackView *itemsContainer;

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
        make.left.and.top.equalTo(@0);
        make.height.equalTo(@44);
        make.right.equalTo(self.arrowImageView.mas_left);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.centerY.equalTo(self.titleLabel);
    }];
    
    [self addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.items = [NSMutableArray array];
    for (int i = 0 ; i < self.titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = i+1;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(buttonCLicked:) forControlEvents:UIControlEventTouchUpInside];
        [_items addObject:button];
    }
    
    OAStackView *container = [[OAStackView alloc] initWithArrangedSubviews:self.items];
    [self addSubview:container];
    [self bringSubviewToFront:container];
    self.itemsContainer = container;
    self.itemsContainer.alpha = 0.0;
    [self.itemsContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@44);
        make.width.equalTo(self);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

-(void)clicked:(id)sender
{
    if (!self.hasShowMenu) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44*(self.items.count + 1));
        }];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.5f;
        self.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
        self.layer.shadowRadius = 3.0f;
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
        self.layer.shadowColor = [UIColor clearColor].CGColor;
    }
    
    [self setNeedsLayout];
    CGFloat angle = self.hasShowMenu?0:M_PI;
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self layoutIfNeeded];
                         self.arrowImageView.layer.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
                         self.itemsContainer.alpha = !self.hasShowMenu;
                     } completion:^(BOOL finished) {
                         self.hasShowMenu = !self.hasShowMenu;
                     }];
}

-(void)buttonCLicked:(UIButton *)sender
{
    self.titleLabel.text = self.titles[sender.tag - 1];
    [self clicked:nil];
    if (self.valueChangedBlock) {
        self.valueChangedBlock(sender.tag - 1);
    }
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
