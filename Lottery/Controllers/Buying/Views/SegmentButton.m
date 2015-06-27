//
//  SegmentButton.m
//  Lottery
//
//  Created by August on 15/6/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "SegmentButton.h"
#import "Colours.h"

@implementation SegmentButton

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
    self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2.0;
    [self setTitleColor:[UIColor black50PercentColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.layer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
    }else{
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
    }
}

@end
