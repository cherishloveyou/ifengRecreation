//
//  ARTagListView.m
//  Board
//
//  Created by August on 15/7/24.
//
//

#import "ARTagListView.h"
#import <Masonry.h>
#import "LotteryGlobal.h"
#import "Colours.h"

static NSString *reuseIdentifier = @"ARTagListItem";

@interface ARTagListView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *tags;

@end

@implementation ARTagListView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    if (self) {
        [self setUp];
    }
    return self;
}

-(instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    if (self) {
        [self setUp];
    }
    return self;
}

#pragma mark - private methods

- (void)setUp {
    self.flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.flowLayout.minimumLineSpacing = 0.0;
    self.flowLayout.minimumInteritemSpacing = 6.0;
    self.contentInset = UIEdgeInsetsMake(0, 12, 0, 12);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.backgroundColor = [UIColor clearColor];
    self.tags = [NSMutableArray array];
    [self registerClass:[ARTagListItem class] forCellWithReuseIdentifier:reuseIdentifier];
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark - public methods

-(void)addTagWithTitle:(NSString *)title
{
    if (title == nil) {
        return;
    }
    [self.tags addObject:title];
    [self reloadData];
}

-(void)addTagsWithTitles:(NSArray *)titles
{
    [self.tags addObjectsFromArray:titles];
    [self reloadData];
}

-(void)removeTagAtIndex:(NSUInteger)index
{
    [self.tags removeObjectAtIndex:index];
    [self reloadData];
}

-(void)removeTagWithTitle:(NSString *)title
{
    [self.tags removeObject:title];
    [self reloadData];
}

-(void)removeAllTags {
    [self.tags removeAllObjects];
    [self reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static ARTagListItem *item = nil;
    if (item == nil) {
        item = [[ARTagListItem alloc] initWithFrame:CGRectZero];
    }
    
    item.titleLabel.text = self.tags[indexPath.row];
    
    CGSize size = [item.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return CGSizeMake(size.width, CGRectGetHeight(self.bounds)-10);
}

#pragma mark - UICollectionViewDataSourece methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tags.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ARTagListItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    item.titleLabel.text = self.tags[indexPath.row];
    return item;
}

#pragma mark - UICollectionViewDelegate methods

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = indexPath.row;
    NSString *title = self.tags[index];
    if ([self.tagListDelegate respondsToSelector:@selector(tagListView:didSelectTagAtIndex:title:)]) {
        [self.tagListDelegate tagListView:self didSelectTagAtIndex:index title:title];
    }
}

@end


@implementation ARTagListItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = [UIColor fadedBlueColor];
    selectedBackgroundView.layer.cornerRadius = CGRectGetHeight(self.bounds)/2.0;
    selectedBackgroundView.clipsToBounds = YES;
    self.selectedBackgroundView = selectedBackgroundView;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:11];
    _titleLabel.textColor = ColorRGB(51, 51, 51);
    _titleLabel.highlightedTextColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@9);
        make.right.mas_equalTo(-9);
        make.top.and.bottom.equalTo(self.contentView);
    }];
}

@end