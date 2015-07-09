//
//  LotteryResultsCell.m
//  Lottery
//
//  Created by 刘继洋 on 15/6/15.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "LotteryResultsCell.h"

@interface LotteryResultsCell ()
/**
 *  全局
 */
{
    /**
     *  最新开奖号码（号码图片）
     */
    __weak IBOutlet UIImageView *_firstImage;
    
    __weak IBOutlet UIImageView *_secondImage;
    
    __weak IBOutlet UIImageView *_ThirdImage;
    
    __weak IBOutlet UIImageView *_fourthImage;
    
    __weak IBOutlet UIImageView *_fifthImage;
    /**
     *  上一期开奖号码（Label）
     */
    __weak IBOutlet UILabel *_firstLabelT;
    
    __weak IBOutlet UILabel *_secondLabelT;
    
    __weak IBOutlet UILabel *_thirdLabelT;
    
    __weak IBOutlet UILabel *_fourthLabelT;
    
    __weak IBOutlet UILabel *_fifthLabelT;
    /**
     *  上上期开奖号码（Label）
     */
    __weak IBOutlet UILabel *_firstLabelTh;
    
    __weak IBOutlet UILabel *_secondLabelTh;
    
    __weak IBOutlet UILabel *_thirdLabelTh;
    
    __weak IBOutlet UILabel *_fourthLabelTh;
    
    __weak IBOutlet UILabel *_fifthLabelTh;
    
}

@end

@implementation LotteryResultsCell

- (void)awakeFromNib {
    // Initialization code
}

- (NSArray *)firstNumbers{
    if (!_firstNumbers) {
        _firstNumbers = [NSArray arrayWithObjects:_firstImage,_secondImage,_ThirdImage,_fourthImage,_fifthImage, nil];
    }
    return _firstNumbers;
}

- (NSArray *)secondNumbers{
    if (!_secondNumbers) {
        _secondNumbers = [NSArray arrayWithObjects:_firstLabelT,_secondLabelT,_thirdLabelT,_fourthLabelT,_fifthLabelT, nil];
    }
    return _secondNumbers;
}

- (NSArray *)thirdNumbers{
    if (!_thirdNumbers) {
        _thirdNumbers = [NSArray arrayWithObjects:_firstLabelTh,_secondLabelTh,_thirdLabelTh,_fourthLabelTh,_fifthLabelTh, nil];
    }
    return _thirdNumbers;
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
- (void)loadDataWithArray:(NSArray*)dataArray{
    
    if (dataArray && dataArray.count>=3) {
        NSDictionary* firstDic = dataArray[0];
        NSDictionary* secondDic = dataArray[1];
        NSDictionary* thirdDic = dataArray[2];
        
        self.lotteryId = [NSString stringWithFormat:@"%@",[firstDic objectForKey:@"LotteryType"]];
        
        self.lotteryName.text = [firstDic objectForKey:@"LotteryName"];
        self.firstDateLabel.text = [NSString stringWithFormat:@"第%@期",[firstDic objectForKey:@"TermNum"]];
        self.secondDateLabel.text = [NSString stringWithFormat:@"第%@期",[secondDic objectForKey:@"TermNum"]];
        self.thirdDateLabel.text = [NSString stringWithFormat:@"第%@期",[thirdDic objectForKey:@"TermNum"]];
        NSString *firstNu = [firstDic objectForKey:@"RatherNum"];
        NSString *secondNu = [secondDic objectForKey:@"RatherNum"];
        NSString *thirdNu = [thirdDic objectForKey:@"RatherNum"];
        [self loadFirstNumbersWithString:firstNu];
        [self loadSecondNumbersWithString:secondNu];
        [self loadThirdNumbersWithString:thirdNu];
    }
}
/**
 *  加载第一列开奖号码
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
 *  加载第二列开奖号码
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
/**
 *  加载第三行开奖号码
 *
 *  @param numbers 号码
 */
- (void)loadThirdNumbersWithString:(NSString*)numbers{
    if (([numbers rangeOfString:@","].location != NSNotFound)) {
        
        NSArray *numberstrings = [numbers componentsSeparatedByString:@","];
        for (int i = 0; i < numberstrings.count && i < self.thirdNumbers.count; i++) {
            UILabel *lable  = self.thirdNumbers[i];
            NSString *substring = numberstrings[i];
            lable.text = substring;
        }
        
    }else{
        for (int i = 0; i<numbers.length && i<self.thirdNumbers.count; i++) {
            NSString *subString = [numbers substringWithRange:NSMakeRange(i, 1)];
            UILabel *numberlabel =  self.thirdNumbers[i];
            numberlabel.text = subString;
        }
    }
}

- (IBAction)justGoToBuyTheLottery:(UIButton *)sender {
    
    GoToBuyLotteryBlock thisBlock = self.buyBlock;
    if (thisBlock) {
        thisBlock(self.lotteryId);
    }
}


@end
