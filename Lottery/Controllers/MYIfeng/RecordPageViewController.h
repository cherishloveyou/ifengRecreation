//
//  RecordPageViewController.h
//  Lottery
//
//  Created by August on 15/7/6.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordPageViewController : UIViewController

@property (nonatomic, strong, readwrite) NSMutableArray *controllers;

-(instancetype)initWithControllers:(NSArray *)controllers;

@end
