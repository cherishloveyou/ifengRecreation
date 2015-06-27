//
//  NumberButton.m
//  Lottery
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "NumberButton.h"
#import <Masonry.h>
#import "Colours.h"

@interface NumberButton ()

@end

@implementation NumberButton

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2.0;
    
    self.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    ;
}

-(void)selectedSetUp
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2.0;

    self.layer.backgroundColor = [UIColor fadedBlueColor].CGColor;
    ;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (self.isSelected) {
        [self selectedSetUp];
    }else{
        [self setUp];
    }
}

@end
