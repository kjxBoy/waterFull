//
//  ViewController.m
//  WaterFlowLayout_OC
//
//  Created by KJX on 2022/9/9.
//

#import "ViewController.h"
#import "JXWaterFullFlowLayout.h"

static NSString * const kIdentifier = @"cellIdentifier";

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, JXWaterfullFlowLayoutDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JXWaterFullFlowLayout *layout = [[JXWaterFullFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.dataSource = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kIdentifier];
    
    [self.view addSubview:collectionView];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - JXWaterfullFlowLayoutDataSource
- (NSInteger)numberOfColsWithLayout:(id)flowLayout {
    return 4;
}

- (CGFloat)waterfullLayout:(id)flowLayout heightForItemAtIndex:(NSInteger)index {
    return arc4random_uniform(150) + 30;
}

@end
