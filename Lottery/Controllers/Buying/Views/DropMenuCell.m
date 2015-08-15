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

NSString *const kSelectPlayOptionNotification = @"kSelectPlayOptionNotification";

@interface DropMenuCell ()

@property (nonatomic, strong) ARGridView *gridView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, weak) DropMenuNode *node;
@property (nonatomic, assign) NSUInteger seletedIndex;

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectPlayOptionNotification:) name:kSelectPlayOptionNotification object:nil];
    
    self.seletedIndex = NSNotFound;
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
    self.gridView.itemHeight = 30;
    self.gridView.itemInset = 20;
    self.gridView.lineInset = 2;
    __weak typeof(self) wself = self;
    [self.gridView setConfiguration:^UIView *(NSUInteger index) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor clearColor].CGColor;
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [button setTitleColor:ColorRGB(102, 102, 102) forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [button addTarget:wself action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        return button;

    }];
    [self.contentView addSubview:self.gridView];
    
    [self.gridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@80);
        make.top.equalTo(@1);
    }];

}

- (void)setUpType1 {
    self.gridView.numberOfItems = 1;
    self.gridView.numberOfColumn = 1;
    [self.gridView reloadAllItems];
}

- (void)setUpType2 {
    self.gridView.numberOfItems = 6;
    self.gridView.numberOfColumn = 3;
    [self.gridView reloadAllItems];
}

- (void)setUpType3 {
    self.gridView.numberOfItems = 2;
    self.gridView.numberOfColumn = 2;
    [self.gridView reloadAllItems];
}

- (void)setUpType4 {
    self.gridView.numberOfItems = 4;
    self.gridView.numberOfColumn = 4;
    [self.gridView reloadAllItems];
}

- (void)setUpType5 {
    self.gridView.numberOfItems = 5;
    self.gridView.numberOfColumn = 5;
    [self.gridView reloadAllItems];
}

- (void)setUpType6 {
    self.gridView.numberOfItems = 4;
    self.gridView.numberOfColumn = 2;
    [self.gridView reloadAllItems];
}

- (void)setUpType7 {
    self.gridView.numberOfItems = 4;
    self.gridView.numberOfColumn = 3;
    [self.gridView reloadAllItems];
}

- (void)setUpType8 {
    self.gridView.numberOfItems = 5;
    self.gridView.numberOfColumn = 3;
    [self.gridView reloadAllItems];
}

#pragma mark - event methods

- (void)buttonClicked:(UIButton *)button {
    
    NSUInteger index = [self.gridView.items indexOfObject:button];
    if (index == self.seletedIndex) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kSelectPlayOptionNotification object:nil];
    
    button.layer.borderColor = ColorRGB(102, 102, 102).CGColor;
    self.seletedIndex = index;
    LotteryPlayOption *option = self.node.options[self.seletedIndex];
    
    if ([self.delegate respondsToSelector:@selector(dropMenuCell:didSelectedOption:)]) {
        [self.delegate dropMenuCell:self didSelectedOption:option];
    }
}

#pragma mark - notification methods

- (void)didSelectPlayOptionNotification:(NSNotification *)notification {
    [self.gridView.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *preButton = self.gridView.items[idx];
        preButton.layer.borderColor = [UIColor clearColor].CGColor;
    }];
}

#pragma mark - row methods

- (void)setUp0 {
    [self setUpType1];
}

- (void)setUp1 {
    [self setUpType2];
}

- (void)setUp2 {
    [self setUpType1];
}

- (void)setUp3 {
    [self setUpType3];
}

- (void)setUp4 {
    [self setUpType1];
}

- (void)setUp5 {
    [self setUpType4];
}

- (void)setUp6 {
    [self setUpType3];
}

- (void)setUp7 {
    [self setUpType4];
}

- (void)setUp8 {
    [self setUpType8];
}

- (void)setUp9 {
    [self setUpType3];
}

- (void)setUp10 {
    [self setUpType1];
}

- (void)setUp11 {
    [self setUpType6];
}

- (void)setUp12 {
    [self setUpType1];
}

- (void)setUp13 {
    [self setUpType3];
}

- (void)setUp14 {
    [self setUpType7];
}


#pragma mark - public methods

- (void)fillCellWithNode:(DropMenuNode *)node {
    self.node = node;
    self.titleLabel.text = node.title;
    [node.options enumerateObjectsUsingBlock:^(LotteryPlayOption *option, NSUInteger idx, BOOL *stop) {
        if (idx < self.gridView.items.count) {
            UIButton *button = self.gridView.items[idx];
            [button setTitle:option.title forState:UIControlStateNormal];
        }
    }];
}

@end
