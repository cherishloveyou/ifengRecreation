//
//  AnnouncementDetailVC.m
//  Lottery
//
//  Created by 刘继洋 on 15/7/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "AnnouncementDetailVC.h"

@interface AnnouncementDetailVC ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIWebView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation AnnouncementDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"公告";
    
    self.titleLabel.text = [self.dataDic objectForKey:@"title"];
    NSString *html = [self.dataDic objectForKey:@"content"];
    
    self.timeLabel.text = [self timeTransformWithTime:[self.dataDic objectForKey:@"addTime"]];
    
    NSURL *url = [NSURL URLWithString:@"string"];
    
    [self.contentView loadHTMLString:html baseURL:url];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  时间转换
 *
 *  @param timeString 时间戳
 *
 *  @return 转换完成的标准时间
 */
- (NSString*)timeTransformWithTime:(NSString*)timeString{
    NSString *newTime = [timeString substringWithRange:NSMakeRange(6, 10)];
    double lastactivityInterval = [newTime  doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH：mm"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:(lastactivityInterval)];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
