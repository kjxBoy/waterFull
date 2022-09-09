//
//  WaterFullFlowLayout.swift
//  swiftWaterFull
//
//  Created by KJX on 2016/12/5.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit


//MARK: 这里是给外部调用的方法
protocol WaterfallLayoutDataSource : AnyObject {
    //返回的列数
    func numberOfCols(_ waterfall : WaterFullFlowLayout) -> Int
    
    
    //每一个Cell的高度
    func waterfall(_ waterfall : WaterFullFlowLayout, item : Int) -> CGFloat
}


class WaterFullFlowLayout: UICollectionViewFlowLayout {
    
     weak var dataSource: WaterfallLayoutDataSource?
    
    //分成几列
    fileprivate lazy var colCount: Int = self.dataSource?.numberOfCols(self) ?? 2
    
    //保存所有的cell的Attributes
    fileprivate lazy var attrs: [UICollectionViewLayoutAttributes] =  []
    
    //保存所有Cell高度的数组
    fileprivate lazy var cellHeights : [CGFloat] = Array(repeating: self.sectionInset.top, count:self.colCount)

}


extension WaterFullFlowLayout{
    
    open override func prepare() {
        
        super.prepare()
        
        guard let collectionView = collectionView else { fatalError("没有CollectionView") }
        
        //宽度
        let width : CGFloat = (collectionView.frame.width - sectionInset.left - sectionInset.right - CGFloat(colCount - 1) * minimumInteritemSpacing) / CGFloat(colCount)
        
        //拿到所有的item
        let cellCount = collectionView.numberOfItems(inSection: 0)
        
        //遍历所有的Cell
        for i in attrs.count ..< cellCount {
            
            let indexPath = IndexPath(item: i, section: 0)
            
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 最小值 (瀑布流是从较小的一边，向下拼接)
            let minH = cellHeights.min()!
            
            // 最小值的索引
            let minIndex = cellHeights.firstIndex(of: minH)!
            
            
            let cellX = sectionInset.left + (minimumInteritemSpacing + width) * CGFloat(minIndex)
            let cellY = minH + minimumLineSpacing
            guard let height : CGFloat = dataSource?.waterfall(self, item: i) else {
                fatalError("请实现对应的数据源方法,并且返回Cell高度")
            }
            
            attr.frame = CGRect(x: cellX, y: cellY, width: width, height: height)
            attrs.append(attr)
            cellHeights[minIndex] = cellY + height
        }
        
        print(attrs.count);
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrs
    }
    
    /// 因为cellHeights保存的是在滚动列表里面实际的高度，这里直接返回
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: cellHeights.max()! + sectionInset.bottom)
    }
}

