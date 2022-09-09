//
//  JXWaterFullFlowLayout.h
//  WaterFlowLayout_OC
//
//  Created by shenxuejian on 2022/9/9.
//

#import <UIKit/UIKit.h>
@class JXWaterFullFlowLayout;

NS_ASSUME_NONNULL_BEGIN

@protocol JXWaterfullFlowLayoutDataSource <NSObject>

- (NSInteger)numberOfColsWithLayout:(JXWaterFullFlowLayout *)flowLayout;

- (CGFloat)waterfullLayout:(JXWaterFullFlowLayout*) flowLayout heightForItemAtIndex:(NSInteger)index;

@end

@interface JXWaterFullFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<JXWaterfullFlowLayoutDataSource> dataSource;
@end

NS_ASSUME_NONNULL_END
