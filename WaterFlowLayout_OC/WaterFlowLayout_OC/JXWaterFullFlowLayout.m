//
//  JXWaterFullFlowLayout.m
//  WaterFlowLayout_OC
//
//  Created by shenxuejian on 2022/9/9.
//

#import "JXWaterFullFlowLayout.h"



@interface JXWaterFullFlowLayout ()
@property (nonatomic, assign) NSInteger colCount;
@property (nonatomic, strong) NSMutableArray *attrs;
@property (nonatomic, strong) NSMutableArray *cellHeights;
@end

@implementation JXWaterFullFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _attrs = [NSMutableArray array];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    if ([self.dataSource respondsToSelector:@selector(numberOfColsWithLayout:)]) {
        self.colCount = [self.dataSource numberOfColsWithLayout:self];
    } else {
        self.colCount = 2;
    }
    
    for (NSInteger i = 0; i < self.colCount; i++) {
        [self.cellHeights addObject:@(self.sectionInset.top)];
    }
    
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.colCount - 1) * self.minimumInteritemSpacing) / self.colCount;
    
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = self.attrs.count; i < cellCount ; i++) {

        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
         
        CGFloat minH = [[self.cellHeights valueForKeyPath:@"@min.floatValue"] floatValue];
        
        NSInteger index = [self.cellHeights indexOfObject:@(minH)];
        
        CGFloat cellX = self.sectionInset.left + (self.minimumInteritemSpacing + width) * index;
        
        CGFloat cellY = minH + self.minimumLineSpacing;
        
        CGFloat height = 30;
        if ([self.dataSource respondsToSelector:@selector(waterfullLayout:heightForItemAtIndex:)]) {
            height = [self.dataSource waterfullLayout:self heightForItemAtIndex:i];
        }
        
        attributes.frame = CGRectMake(cellX, cellY, width, height);
        [self.attrs addObject:attributes];
        self.cellHeights[index] = @(cellY + height);
    }
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrs;
}

- (CGSize)collectionViewContentSize {
    
    CGFloat maxH = [[self.cellHeights valueForKeyPath:@"@max.floatValue"] floatValue];
    return CGSizeMake(0, maxH + self.sectionInset.bottom);
}

- (NSMutableArray *)cellHeights {
    if (_cellHeights == nil) {
        _cellHeights = [NSMutableArray array];
    }
    return _cellHeights;
        
}


@end
