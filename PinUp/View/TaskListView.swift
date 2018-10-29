//
//  TaskListView.swift
//  PinUp
//
//  Created by Xavier Davis on 10/22/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import Foundation
import UIKit

class TaskListView: UIView {
     var collectionView : UICollectionView
    var taskSwitcher : UISegmentedControl
    
    override init(frame: CGRect) {
        
        collectionView = {
            let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
            collectionView.backgroundColor = UIColor.init(hex: "#4d86e2")
            return collectionView
        }()
        
        taskSwitcher = {
            let segmentedControl = UISegmentedControl()
            segmentedControl.insertSegment(withTitle: "Created Task", at: 0, animated: true)
            segmentedControl.insertSegment(withTitle: "Accepted Task", at: 1, animated: true)
            segmentedControl.setEnabled(true, forSegmentAt: 0)
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.backgroundColor = UIColor.clear
            segmentedControl.tintColor = UIColor.green
            
            return segmentedControl
        }()
        
        super.init(frame: frame)
        backgroundColor = collectionView.backgroundColor
        addSubview(taskSwitcher)
        addSubview(collectionView)
        
        taskSwitcher.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(taskSwitcher.snp.bottom).offset(5  )
            make.left.right.bottom.equalToSuperview()
//            make.bottom.equalTo(bottomNavView.snp.top)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
