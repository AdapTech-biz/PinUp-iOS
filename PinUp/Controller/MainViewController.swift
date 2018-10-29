//
//  MainViewController.swift
//  PinUp
//
//  Created by Xavier Davis on 10/27/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var searchViewController = SearchBarViewController()
    var bottomNavViewController = BottomNavViewController()
    var taskListViewController = TaskListViewController()
    lazy var transactionController : MinimumViewController = {
        let viewController = MinimumViewController()
        return viewController
    }()
    
    var poppedViewControllers = [UIViewController]()
    var position : (ConstraintMaker) -> Void = {_ in }
    var tabBar : UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegates()

        
        position = { make in
            make.top.equalTo(self.searchViewController.view.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.bottomNavViewController.view.snp.top)
        }
        
        addChildAsChildViewController(searchViewController)
        addChildAsChildViewController(bottomNavViewController)
        addChildAsChildViewController(taskListViewController)


    }
    
    // MARK: - Delegate Management
    
    func assignDelegates(){
        bottomNavViewController.delegate = self
    }
    
    // MARK: - View Constraints
    ///////////////////////////////////////////////////////////
    
    func setupViewContraints(){
        
        searchViewController.view.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        
        bottomNavViewController.view.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.right.bottom.equalToSuperview()
        }
        
        taskListViewController.view.snp.makeConstraints(position)
    }
    
    ////////////////////////////////////////////////////////////
    
    func addChildAsChildViewController(_ childVC : UIViewController){
        
        if poppedViewControllers.contains(childVC){
            let index = poppedViewControllers.firstIndex(of: childVC)
           let poppedVC = poppedViewControllers.remove(at: index!)
            addChild(poppedVC)
            view.addSubview(poppedVC.view)
            poppedVC.didMove(toParent: self)
        } else{
            addChild(childVC)
            view.addSubview(childVC.view)
            childVC.didMove(toParent: self)
        }
        
        
        
    }
    
    func removeViewControllerFromParent(_ childVC : UIViewController){
    
        if !poppedViewControllers.contains(childVC) {
            poppedViewControllers.append(childVC)
        }
        
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }
    


}

extension MainViewController : tabNavigationDelegate{

    func tabBarPressed(tabTitle: String) {
        switch tabTitle {
        case "Transactions":
            removeViewControllerFromParent(taskListViewController)
            addChildAsChildViewController(transactionController)
            transactionController.view.snp.makeConstraints(position)
        default:
            removeViewControllerFromParent(transactionController)
            addChildAsChildViewController(taskListViewController)
            taskListViewController.view.snp.makeConstraints(position)
        }
        
    }
}
