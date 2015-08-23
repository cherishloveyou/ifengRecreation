//
//  SelectNumbersCell.m
//  Lottery
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "SelectNumbersCell.h"
#import "NumberButton.h"
#import "SegmentButton.h"
#import "ARGridView.h"
#import <ReactiveCocoa.h>

@interface SelectNumbersCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) CALayer *backLayer;
@property (weak, nonatomic) IBOutlet OAStackView *stackView;

@property (nonatomic, assign) BOOL canMutileSelected;
@property (nonatomic, assign) NumberCellType cellType;

@end

@implementation SelectNumbersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    self.backLayer = [CALayer layer];
    self.backLayer.cornerRadius = 2;
    self.backLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer insertSublayer:self.backLayer atIndex:0];
    
    self.gridView.numberOfColumn = 6;
    self.gridView.itemWidth = 36;
    self.gridView.itemHeight = 36;
    self.gridView.itemInset = 10;
    
    self.stackView.distribution = OAStackViewDistributionFillEqually;
    
    @weakify(self);
    [RACObserve(self, canMutileSelected) subscribeNext:^(id x) {
        @strongify(self);
        self.stackView.hidden = ![x boolValue];
    }];
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    [self.gridView.items enumerateObjectsUsingBlock:^(NumberButton *button, NSUInteger idx, BOOL *stop) {
        button.selected = NO;
    }];
    
    for (SegmentButton *button in self.stackView.subviews) {
        button.selected = NO;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backLayer.frame = CGRectMake(10, 5, CGRectGetWidth(self.bounds)-20, CGRectGetHeight(self.bounds)-10);
}

- (void)fillCellWithNode:(NumberCellNode *)node {
    
    switch (node.cellType) {
        case NumberCellTypeDefault: {
            self.canMutileSelected = YES;
            self.gridView.numberOfItems = 10;
            self.gridView.configuration = ^UIView *(NSUInteger index){
                NumberButton *button = [[NumberButton alloc] init];
                button.index = index;
                [button setTitle:[NSString stringWithFormat:@"%ld",index] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                return button;
            };

            break;
        }
        case NumberCellTypeHeZhi: {
            self.canMutileSelected = YES;
            self.gridView.numberOfItems = 26;
            self.gridView.configuration = ^UIView *(NSUInteger index){
                NumberButton *button = [[NumberButton alloc] init];
                button.index = index;
                [button setTitle:[NSString stringWithFormat:@"%ld",index+1] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                return button;
            };

            break;
        }
        case NumberCellTypeBaoDan: {
            self.canMutileSelected = NO;
            self.gridView.numberOfItems = 10;
            self.gridView.configuration = ^UIView *(NSUInteger index){
                NumberButton *button = [[NumberButton alloc] init];
                button.index = index;
                [button setTitle:[NSString stringWithFormat:@"%ld",index] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                return button;
            };

            break;
        }
        case NumberCellTypeSD11X5: {
            self.canMutileSelected = YES;
            self.gridView.numberOfItems = 11;
            self.stackView.hidden = YES;
            self.gridView.configuration = ^UIView *(NSUInteger index){
                NumberButton *button = [[NumberButton alloc] init];
                button.index = index;
                [button setTitle:[NSString stringWithFormat:@"%2ld",index+1] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                return button;
            };

            break;
        }
        default: {
            break;
        }
    }
    
    [self.gridView reloadAllItems];
    
    self.titleLabel.text = node.title;
    [node.numbersSet enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSUInteger index = [obj integerValue];
        NumberButton *button = self.gridView.items[index];
        [button setSelected:YES];
    }];
    
    if (node.segmentSelectIndex != NSNotFound) {
        for (SegmentButton *button in self.stackView.subviews) {
            button.selected = button.index == node.segmentSelectIndex?YES:NO;
        }
    }
}

#pragma mark - event methods

- (IBAction)numberButtonClicked:(NumberButton *)sender {
    if (self.canMutileSelected == NO) {
        [self.gridView.items enumerateObjectsUsingBlock:^(NumberButton *button, NSUInteger idx, BOOL *stop) {
            button.selected = NO;
        }];
    }
    [sender setSelected:!sender.isSelected];
    if ([self.delegate respondsToSelector:@selector(numbersCell:seletedNumber:isSelected:)]) {
        [self.delegate numbersCell:self seletedNumber:sender.index isSelected:sender.isSelected];
    }
}


- (IBAction)segmentButtonClicked:(SegmentButton *)sender {
    for (SegmentButton *button in self.stackView.subviews) {
        button.selected = NO;
    }
    sender.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(numbersCell:segmentTitle:selectIndex:)]) {
        [self.delegate numbersCell:self segmentTitle:self.stackView selectIndex:sender.index];
    }
}

@end
