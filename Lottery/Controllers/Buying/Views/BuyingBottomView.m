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

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

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
    
    
    self.clipsToBounds = YES;
    self.canBuyLottery = NO;
    self.backImageView = [[UIImageView alloc] init];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.image = [UIImage imageNamed:@"numbers_Bag"];
    [self addSubview:self.backImageView];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.backgroundColor = ColorRGB(253, 178, 48);
    [self.leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightButton];
    
    self.addImageView = [[UIImageView alloc] init];
    self.addImageView.image = [[UIImage imageNamed:@"add_Button"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.addImageView.tintColor = [UIColor whiteColor];
    [self addSubview:self.addImageView];
    
    self.topLabel = [[UILabel alloc] init];
    self.topLabel.font = [UIFont systemFontOfSize:14];
    self.topLabel.text = [NSString stringWithFormat:@"已选0注，0元"];
    self.topLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.topLabel];
    
    self.bottomLabel = [[UILabel alloc] init];
    self.bottomLabel.font = [UIFont systemFontOfSize:12];
    self.bottomLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.bottomLabel];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
        make.left.and.top.and.bottom.and.right.equalTo(@0);
    }];
    NSLog(@"%.2f",SCREENWIDTH);
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.equalTo(@0);
        make.top.equalTo(@0);
        if (SCREENWIDTH==320) {
            make.right.equalTo(@-90);
        }else if(SCREENWIDTH == 375){
            make.right.equalTo(@-105);
        }else {
            make.right.equalTo(@-115);
        }
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
        make.right.lessThanOrEqualTo(self.leftButton).offset(-10);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addImageView.mas_right).offset(5);
        make.top.equalTo(self.topLabel.mas_bottom).offset(2);
        make.height.equalTo(@20);
        make.right.lessThanOrEqualTo(self.leftButton).offset(-10);
    }];
    
    self.maskLayer = [CAShapeLayer layer];
    self.maskLayer.fillColor = [UIColor blackColor].CGColor;
    self.leftButton.layer.mask = self.maskLayer;
    
    @weakify(self);
    [RACObserve(self, canBuyLottery) subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            self.leftButton.backgroundColor = ColorRGB(253, 178, 48);
        }else{
            self.leftButton.backgroundColor = [UIColor clearColor];
        }
    }];
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

#pragma mark - event methods

- (void)leftButtonClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(bottomBar:leftButtonClicked:)]) {
        [self.delegate bottomBar:self leftButtonClicked:sender];
    }
}

- (void)rightButtonClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(bottomBar:rightButtonClicked:)]) {
        [self.delegate bottomBar:self rightButtonClicked:sender];
    }
}

@end
