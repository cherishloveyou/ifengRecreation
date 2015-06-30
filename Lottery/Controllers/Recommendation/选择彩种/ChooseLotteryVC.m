//
//  ChooseLotteryVC.m
//  Lottery
//
//  Created by 刘继洋 on 15/6/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ChooseLotteryVC.h"
#import "ChooseLotteryCell.h"

@interface ChooseLotteryVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation ChooseLotteryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self.collectionView registerClass:[ChooseLotteryCell class] forCellWithReuseIdentifier:@"ChooseLotteryCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ChooseLotteryCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ChooseLotteryCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  关闭
 *
 *  @param sender
 */
- (IBAction)closePage:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  完成选择
 *
 *  @param sender
 */

- (IBAction)choosedLotteryDone:(id)sender{
    
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChooseLotteryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseLotteryCell" forIndexPath:indexPath];
    if (indexPath.section == 0&& indexPath.row ==  0) {
        cell.isNewLottery.hidden = NO;
    }
    
    return cell;
}

#pragma mark -- UICollectionViewDelegate

//每个section中不同的行之间的行间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 1;
//}
////每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 1, 1);//分别为上、左、下、右
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGSize size = CGSizeMake((screenWidth - 3)/3.0, (screenWidth - 2)/3.0);
    
    return size;
}

@end
