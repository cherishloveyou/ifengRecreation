//
//  FFScrollView.h
//  ScrollViewDemo
//
//  Created by Juncy_Fan on 13-11-11.
//  Copyright (c) 2013年 aifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置16进制颜色
 */
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define PHOTOURL @"http://111.9.116.66:8091/"

typedef enum
{
    FFScrollViewSelecttionTypeTap = 100,  //默认的为可点击模式
    FFScrollViewSelecttionTypeNone   //不可点击的
}FFScrollViewSelecttionType;

@protocol FFScrollViewDelegate <NSObject>

@optional
- (void)scrollViewDidClickedAtPage:(NSInteger)pageNumber;

@end

@interface FFScrollView : UIView <UIScrollViewDelegate>
{
    NSTimer *timer;
    NSArray *sourceArr;
}
@property(strong,nonatomic) UIScrollView *scrollView;
@property(strong,nonatomic) UIPageControl *pageControl;
@property(assign,nonatomic) FFScrollViewSelecttionType selectionType;
@property(assign,nonatomic) id <FFScrollViewDelegate> pageViewDelegate;

- (id)initPageViewWithFrame:(CGRect)frame views:(NSArray *)views;

@end
