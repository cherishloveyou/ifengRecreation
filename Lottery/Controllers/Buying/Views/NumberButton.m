//
//  NumberButton.m
//  Lottery
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "NumberButton.h"
#import <Masonry.h>

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

}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    CGContextSetLineWidth(context, 1);
    CGContextAddPath(context, circle.CGPath);
    CGFloat lengths[] = {2,1};
    CGContextSetLineDash(context, 10, lengths, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokePath(context);
}

@end
