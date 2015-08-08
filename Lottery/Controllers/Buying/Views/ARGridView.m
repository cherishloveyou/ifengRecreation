//
//  ARGridView.m
//  ARControlsDemo
//
//  Created by August on 15/8/7.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARGridView.h"

static CGFloat ARGridViewAbsentValue = -1;

@interface ARGridView ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ARGridView

#pragma mark - init methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

#pragma mark - private methods

- (void)setUp {
    self.itemInset = 1;
    self.lineInset = 1;
    self.numberOfItems = 0;
    self.numberOfColumn = 0;
    self.itemWidth = ARGridViewAbsentValue;
    self.itemHeight = ARGridViewAbsentValue;
    self.items = [NSMutableArray array];
}

#pragma mark - public methods

- (void)reloadAllItems {
    NSAssert(self.configuration != nil, @"configuration should not be nil!");
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.items removeAllObjects];
    
    for (NSUInteger count = 0; count < self.numberOfItems; count++) {
        UIView *view = self.configuration(count);
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        
        NSUInteger column = count % self.numberOfColumn;
        NSUInteger line = count/self.numberOfColumn;
        
        [self layoutItem:view atIndex:count column:column line:line];
        
        [self.items addObject:view];
    }

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutItem:(UIView *)item atIndex:(NSUInteger)index column:(NSUInteger)column line:(NSUInteger)line {
    if (self.itemWidth != ARGridViewAbsentValue) {
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.itemWidth];
        [item addConstraint:widthConstraint];
    }
    
    if (self.itemHeight != ARGridViewAbsentValue) {
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.itemHeight];
        [item addConstraint:heightConstraint];
    }
    
    if (column == 0) {
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        [self addConstraint:leftConstraint];
    }else{
        UIView *preView = self.items[index - 1];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:preView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeLeft multiplier:1 constant:-self.itemInset];
        [self addConstraint:leftConstraint];
    }
    
    if (line == 0) {
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        [self addConstraint:topConstraint];
    }else{
        NSUInteger topViewIndex = self.numberOfColumn*line - self.numberOfColumn + column;
        UIView *topView = self.items[topViewIndex];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:topView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeTop multiplier:1 constant:-self.lineInset];
        topConstraint.identifier = [NSString stringWithFormat:@"L-C-%lu,L-%lu",(unsigned long)column,(unsigned long)line];
        [self addConstraint:topConstraint];
    }
    
    if (column == self.numberOfColumn - 1) {
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        [self addConstraint:rightConstraint];
    }
    
    if (index == self.numberOfItems - 1) {
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [self addConstraint:bottomConstraint];
    }
}

- (UIColor *)randomColor
{
    CGFloat r = (arc4random()%255)/255.0;
    CGFloat g = (arc4random()%255)/255.0;
    CGFloat b = (arc4random()%255)/255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


@end
