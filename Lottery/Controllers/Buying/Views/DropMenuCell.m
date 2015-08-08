//
//  DropMenuCell.m
//  Lottery
//
//  Created by August on 15/8/8.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "DropMenuCell.h"
#import "LotteryGlobal.h"
#import <Masonry.h>
#import "ARGridView.h"

@interface DropMenuCell ()

@property (nonatomic, strong) ARGridView *gridView;

@end

@implementation DropMenuCell

#pragma mark - init mehtods

- (instancetype)initWithIndex:(NSUInteger)index reuseIdentifier:(NSString *)identifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (self) {
        [self baseSetUp];
        NSString *selectorName = [NSString stringWithFormat:@"setUp%ld",index];
        SEL selector = NSSelectorFromString(selectorName);
        [self performSelector:selector];
    }
    return self;
}

- (void)baseSetUp {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = ColorRGB(102, 102, 102);
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.width.mas_equalTo(60);
        make.top.equalTo(@0);
        make.height.equalTo(@30);
    }];
    
    self.gridView = [[ARGridView alloc] init];
    [self.contentView addSubview:self.gridView];
    [self.gridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@2);
        make.bottom.mas_equalTo(-2);
    }];

}

- (void)setUpType1 {

}

- (void)setUpType2 {
    
    UIButton *button = [[UIButton alloc] init];
    [self.contentView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@2);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
}

#pragma mark - row methods

- (void)setUp0 {
    [self setUpType1];
}

- (void)setUp1 {
    [self setUpType1];
}

- (void)setUp2 {
    [self setUpType1];
}

- (void)setUp3 {
    [self setUpType1];
}

- (void)setUp4 {
    [self setUpType1];
}

- (void)setUp5 {
    [self setUpType1];
}

- (void)setUp6 {
    [self setUpType1];
}

- (void)setUp7 {
    [self setUpType1];
}

- (void)setUp8 {
    [self setUpType1];
}

- (void)setUp9 {
    [self setUpType1];
}

- (void)setUp10 {
    [self setUpType1];
}

- (void)setUp11 {
    [self setUpType1];
}

- (void)setUp12 {
    [self setUpType1];
}

- (void)setUp13 {
    [self setUpType1];
}

- (void)setUp14 {
    [self setUpType1];
}


#pragma mark - public methods

- (void)fillCellWithNode:(DropMenuNode *)node {
    self.titleLabel.text = node.title;
    [node.options enumerateObjectsUsingBlock:^(NSString *option, NSUInteger idx, BOOL *stop) {
        if (idx < self.gridView.items.count) {
            UIButton *button = self.gridView.items[idx];
            [button setTitle:option forState:UIControlStateNormal];
        }
    }];
}

@end
