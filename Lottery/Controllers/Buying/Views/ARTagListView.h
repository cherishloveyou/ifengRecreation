//
//  ARTagListView.h
//  Board
//
//  Created by August on 15/7/24.
//
//

#import <UIKit/UIKit.h>

@class ARTagListItem;
@class ARTagListView;

@protocol ARTagListViewDelegate <NSObject>

-(void)tagListView:(ARTagListView *)tagListView didSelectTagAtIndex:(NSUInteger)index title:(NSString *)title;

@end

@interface ARTagListView : UICollectionView

@property (nonatomic, weak) IBOutlet id<ARTagListViewDelegate> tagListDelegate;

-(void)addTagWithTitle:(NSString *)title;
-(void)addTagsWithTitles:(NSArray *)titles;

-(void)removeTagAtIndex:(NSUInteger)index;
-(void)removeTagWithTitle:(NSString *)title;
-(void)removeAllTags;

@end

/**
 *  items
 */

@interface ARTagListItem : UICollectionViewCell

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIImageView *imageView;

@end

@interface ARTagListItem1 : UICollectionViewCell

@property (nonatomic, strong, readonly) UILabel *titleLabel;

@end
