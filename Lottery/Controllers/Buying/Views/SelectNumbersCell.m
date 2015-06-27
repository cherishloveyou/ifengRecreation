//
//  SelectNumbersCell.m
//  Lottery
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "SelectNumbersCell.h"
#import "NumberButton.h"

@interface SelectNumbersCell ()
@property (weak, nonatomic) IBOutlet NumberButton *numberButton0;
@property (weak, nonatomic) IBOutlet NumberButton *numberButton1;
@property (weak, nonatomic) IBOutlet NumberButton *numberButton2;
@property (weak, nonatomic) IBOutlet NumberButton *numberButton3;
@property (weak, nonatomic) IBOutlet NumberButton *numberButton4;
@property (weak, nonatomic) IBOutlet NumberButton *numberButton5;
@property (weak, nonatomic) IBOutlet NumberButton *numberButton6;
@property (weak, nonatomic) IBOutlet NumberButton *numberButton7;
@property (weak, nonatomic) IBOutlet NumberButton *numberButton8;
@property (weak, nonatomic) IBOutlet NumberButton *numberButton9;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) CALayer *backLayer;

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
    
    self.numberButton0.index = 0;
    self.numberButton1.index = 1;
    self.numberButton2.index = 2;
    self.numberButton3.index = 3;
    self.numberButton4.index = 4;
    self.numberButton5.index = 5;
    self.numberButton6.index = 6;
    self.numberButton7.index = 7;
    self.numberButton8.index = 8;
    self.numberButton9.index = 9;

}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.numberButton0.selected = NO;
    self.numberButton1.selected = NO;
    self.numberButton2.selected = NO;
    self.numberButton3.selected = NO;
    self.numberButton4.selected = NO;
    self.numberButton5.selected = NO;
    self.numberButton6.selected = NO;
    self.numberButton7.selected = NO;
    self.numberButton8.selected = NO;
    self.numberButton9.selected = NO;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backLayer.frame = CGRectMake(10, 5, CGRectGetWidth(self.bounds)-20, CGRectGetHeight(self.bounds)-10);
}

-(void)fillCellWithNumbersSet:(NSMutableOrderedSet *)numbersSet title:(NSString *)title
{
    self.titleLabel.text = title;
    [numbersSet enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *key = [NSString stringWithFormat:@"numberButton%@",obj];
        NumberButton *button = [self valueForKey:key];
        [button setSelected:YES];
    }];
}

- (IBAction)bumberButtonClicked:(NumberButton *)sender {
    [sender setSelected:!sender.isSelected];
    if ([self.delegate respondsToSelector:@selector(numbersCell:seletedNumber:isSelected:)]) {
        [self.delegate numbersCell:self seletedNumber:sender.index isSelected:sender.isSelected];
    }
}

@end
