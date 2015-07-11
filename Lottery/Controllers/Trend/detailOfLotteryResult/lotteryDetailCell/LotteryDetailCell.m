//
//  LotteryDetailCell.m
//  Lottery
//
//  Created by 刘继洋 on 15/7/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "LotteryDetailCell.h"

@interface LotteryDetailCell ()
{
    /**
     *  最新开奖号码（号码图片）
     */
    __weak IBOutlet UIImageView *_firstImage;
    
    __weak IBOutlet UIImageView *_secondImage;
    
    __weak IBOutlet UIImageView *_ThirdImage;
    
    __weak IBOutlet UIImageView *_fourthImage;
    
    __weak IBOutlet UIImageView *_fifthImage;
    
    __weak IBOutlet UIImageView *_sexthImage;
    
    __weak IBOutlet UIImageView *_seventhImage;
    /**
     *  上一期开奖号码（Label）
     */
    __weak IBOutlet UILabel *_firstLabelT;
    
    __weak IBOutlet UILabel *_secondLabelT;
    
    __weak IBOutlet UILabel *_thirdLabelT;
    
    __weak IBOutlet UILabel *_fourthLabelT;
    
    __weak IBOutlet UILabel *_fifthLabelT;
    
    __weak IBOutlet UILabel *_sexthLabelt;
    
    __weak IBOutlet UILabel *_seventhLabelt;
}
/**
 *  开奖期数
 */
@property (weak, nonatomic) IBOutlet UILabel *lotteryTerm;
/**
 *  最新开奖号码数组（images）
 */
@property (strong, nonatomic) NSArray *firstNumbers;
/**
 *  上一期开奖号码（labels）
 */
@property (strong, nonatomic) NSArray *secondNumbers;

@end

@implementation LotteryDetailCell

- (NSArray *)firstNumbers{
    if (!_firstNumbers) {
        _firstNumbers = [NSArray arrayWithObjects:_firstImage,_secondImage,_ThirdImage,_fourthImage,_fifthImage,_sexthImage,_seventhImage, nil];
    }
    return _firstNumbers;
}

- (NSArray *)secondNumbers{
    if (!_secondNumbers) {
        _secondNumbers = [NSArray arrayWithObjects:_firstLabelT,_secondLabelT,_thirdLabelT,_fourthLabelT,_fifthLabelT,_sexthLabelt,_seventhLabelt, nil];
    }
    return _secondNumbers;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  装载数据
 *
 *  @param dataArray 数据源
 {
 LotteryName = "\U91cd\U5e86\U65f6\U65f6\U5f69";
 LotteryType = 1;
 RatherNum = 33182;
 TermNum = 20150708006;
 }
 */
- (void)loadDataWithDictionary:(NSDictionary*)datadic{
    for (UIImageView *imageView in self.firstNumbers) {
        [imageView setImage:nil];
    }
    
    for (UILabel *label in self.secondNumbers) {
        label.text = @"";
    }
        
    self.lotteryId = [NSString stringWithFormat:@"%@",[datadic objectForKey:@"LotteryType"]];
    NSString *firstNu = [datadic objectForKey:@"RatherNum"];
    if (self.cellStyle == LotteryDetailCellStyleImageNumbers) {
        [self loadFirstNumbersWithString:firstNu];
        return;
    }
    
    [self loadSecondNumbersWithString:firstNu];
    
}

/**
 *  以图片形式显示开奖结果
 *
 *  @param numbers 号码
 */
- (void)loadFirstNumbersWithString:(NSString*)numbers{
    if (([numbers rangeOfString:@","].location != NSNotFound)) {
        
        NSArray *numberstrings = [numbers componentsSeparatedByString:@","];
        for (int i = 0; i < numberstrings.count && i < self.firstNumbers.count; i++) {
            UIImageView *view  = self.firstNumbers[i];
            NSString *substring = numberstrings[i];
            view.image = [UIImage imageNamed:substring];
        }
        
    }else{
        for (int i = 0; i<numbers.length && i<self.firstNumbers.count; i++) {
            NSString *subString = [numbers substringWithRange:NSMakeRange(i, 1)];
            UIImageView *numberimage =  self.firstNumbers[i];
            numberimage.image = [UIImage imageNamed:subString];
        }
        
    }
}
/**
 *  以Label形式显示开奖结果
 *
 *  @param numbers 号码
 */
- (void)loadSecondNumbersWithString:(NSString*)numbers{
    if (([numbers rangeOfString:@","].location != NSNotFound)) {
        NSArray *numberstrings = [numbers componentsSeparatedByString:@","];
        for (int i = 0; i < numberstrings.count && i < self.secondNumbers.count; i++) {
            UILabel *lable  = self.secondNumbers[i];
            NSString *substring = numberstrings[i];
            lable.text = substring;
        }
        
    }else{
        for (int i = 0; i<numbers.length && i<self.secondNumbers.count; i++) {
            NSString *subString = [numbers substringWithRange:NSMakeRange(i, 1)];
            UILabel *numberlabel =  self.secondNumbers[i];
            numberlabel.text = subString;
        }
    }
}



@end
