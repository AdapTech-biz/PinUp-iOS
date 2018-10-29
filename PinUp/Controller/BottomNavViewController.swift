//
//  BottomNavViewController.swift
//  PinUp
//
//  Created by Xavier Davis on 10/27/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit

protocol tabNavigationDelegate {
    func tabBarPressed(tabTitle : String)
}

class BottomNavViewController: UIViewController {
    
    var bottomNavView = BottomNavView()
    var tabBar : UITabBar!
    var delegate : tabNavigationDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        linkOutlets()
        configureDelegates()
        addView()
        
        
    }
    // MARK: - Child View Management
    
    func addView(){
        view.addSubview(bottomNavView)
        bottomNavView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    // MARK: - UI Element Management
    
    func linkOutlets(){
        tabBar = bottomNavView.tabBar
    }
    
    func configureDelegates(){
        tabBar.delegate = self
    }


}

extension BottomNavViewController : UITabBarDelegate{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title! {
        case "Transactions":
            print("Go to transactions")
            delegate?.tabBarPressed(tabTitle: "Transactions")
        default:
            print("Other tab pressed...")
            delegate?.tabBarPressed(tabTitle: "Home")
        }
    }
}
