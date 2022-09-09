//
//  ViewController.swift
//  swift_waterFull
//
//  Created by KJX on 2022/9/8.
//

import UIKit

class ViewController: UIViewController {
    private let margin : CGFloat = 10
    private let kCollectionIdentifier = "kCollectionIdentifier"
    
    fileprivate lazy var itemCount : Int = 20

    fileprivate lazy var collectionView : UICollectionView = {
        
        let layout = WaterFullFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: margin, right: margin)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.dataSource = self
        
        
        let collecitonView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collecitonView.backgroundColor = .white
        collecitonView.dataSource = self
        collecitonView.delegate = self
        collecitonView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionIdentifier)
        
        return collecitonView
    
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(collectionView)
    }
}

// Use of unresolved identifier 'itemCount'
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionIdentifier, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell

    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemCount += 20
        collectionView.reloadData()
    }
}

extension ViewController: WaterfallLayoutDataSource{
    func numberOfCols(_ waterfall : WaterFullFlowLayout) -> Int{
        return 3
    }
    
    
    func waterfall(_ waterfall : WaterFullFlowLayout, item : Int) -> CGFloat{
        return CGFloat(arc4random_uniform(150) + 100)
    }
}

