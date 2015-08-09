//
//  BuyingBottomView.m
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "BuyingBottomView.h"
#import <Masonry.h>
#import "LotteryGlobal.h"
#import <ReactiveCocoa.h>

@interface BuyingBottomView ()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation BuyingBottomView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    self.hasSelectedCount = 0;
    self.totalMoney = 0.00;
    
    self.backImageView = [[UIImageView alloc] init];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.image = [UIImage imageNamed:@"numbers_Bag"];
    [self addSubview:self.backImageView];
    
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.backgroundColor = ColorRGB(253, 178, 48);
    [self addSubview:self.leftButton];
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightButton];
    
    self.addImageView = [[UIImageView alloc] init];
    self.addImageView.image = [[UIImage imageNamed:@"add_Button"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.addImageView.tintColor = [UIColor whiteColor];
    [self addSubview:self.addImageView];
    
    self.topLabel = [[UILabel alloc] init];
    self.topLabel.font = [UIFont systemFontOfSize:14];
    self.topLabel.text = [NSString stringWithFormat:@"已选%ld注，%2f元",self.hasSelectedCount,self.totalMoney];
    self.topLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.topLabel];
    
    self.bottomLabel = [[UILabel alloc] init];
    self.bottomLabel.font = [UIFont systemFontOfSize:12];
    self.bottomLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.bottomLabel];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.equalTo(@0);
        make.top.equalTo(@-1);
        make.right.equalTo(@-90);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftButton.mas_right);
        make.top.and.right.and.bottom.equalTo(@0);
    }];
    
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self);
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addImageView.mas_right).offset(5);
        make.top.equalTo(@5);
        make.height.equalTo(@20);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addImageView.mas_right).offset(5);
        make.top.equalTo(self.topLabel.mas_bottom).offset(2);
        make.height.equalTo(@20);
    }];
    
    self.maskLayer = [CAShapeLayer layer];
    self.maskLayer.fillColor = [UIColor blackColor].CGColor;
    self.leftButton.layer.mask = self.maskLayer;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.leftButton.bounds)-10, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.leftButton.bounds), CGRectGetHeight(self.leftButton.bounds)/2.0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.leftButton.bounds)-10, CGRectGetHeight(self.leftButton.bounds))];
    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(self.leftButton.bounds))];
    [path closePath];
    self.maskLayer.path = path.CGPath;
}

@end
