//
//  TaskListViewController.swift
//  PinUp
//
//  Created by Xavier Davis on 10/22/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {
    let taskListView = TaskListView()
    var collectionView : UICollectionView!
    var taskSwitcher : UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hellooo")
        view.addSubview(taskListView)
        taskListView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        collectionView = taskListView.collectionView
        taskSwitcher = taskListView.taskSwitcher
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.contentInset = UIEdgeInsets.init(top: 40.0, left: 10.0, bottom: 10.0, right: 10.0)
        
         taskSwitcher.addTarget(self, action: #selector(segmentControlPressed), for: .valueChanged)


        // Do any additional setup after loading the view.
    }
    
    @objc func segmentControlPressed(){
        switch taskSwitcher.selectedSegmentIndex{
        case 0:
            print("Created Tasks")
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionView.backgroundColor = UIColor.init(hex: "#4d86e2")
            })
        default:
            print("Accepted Task")
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionView.backgroundColor = UIColor.init(hex: "#1b4b99")
            })
        }
            taskListView.backgroundColor = collectionView.backgroundColor
    }
    


}

extension TaskListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView.indexPathsForSelectedItems?.first {
        case .some(indexPath):
            return CGSize(width: collectionView.frame.width-20, height: 400) // your selected height
        default:
            return CGSize(width: collectionView.frame.width-20, height: 246)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.performBatchUpdates(nil, completion: nil)
        
    }
    
}
