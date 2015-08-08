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

@interface BuyingBottomView ()

@property (nonatomic, strong) UIImageView *backImageView;

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
    self.backImageView = [[UIImageView alloc] init];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.image = [UIImage imageNamed:@"numbers_Bag"];
    [self addSubview:self.backImageView];
    
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.backgroundColor = ColorRGB(253, 178, 48);
    [self addSubview:self.leftButton];
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightButton];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(@0);
        make.right.equalTo(@-100);
    }];
}

@end
