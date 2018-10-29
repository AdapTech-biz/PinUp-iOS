//
//  HomeView.swift
//  PinUp
//
//  Created by Xavier Davis on 8/5/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class BottomNavView : UIView{
   
    var tabBar : UITabBar
    var partnershipNavBtn : UITabBarItem
    var homeTabItem : UITabBarItem
    var transactionsTabItem : UITabBarItem
    
    override init(frame: CGRect) {

        partnershipNavBtn = {
           let tabItem = UITabBarItem()
            tabItem.title = "Partnerships"
            tabItem.image = #imageLiteral(resourceName: "partnership_Icon")
            return tabItem
            
        }()
        
        homeTabItem = {
            let tabItem = UITabBarItem()
            tabItem.title = "Home"
            tabItem.image = #imageLiteral(resourceName: "home_icon")
            return tabItem
            
        }()
        
        transactionsTabItem = {
            let tabItem = UITabBarItem()
            tabItem.title = "Transactions"
            tabItem.image = #imageLiteral(resourceName: "transaction_icon")
            return tabItem
            
        }()
        
        tabBar = {
            let tabBar = UITabBar()
            return tabBar
        }()
        
       
        super.init(frame: frame)
        backgroundColor = UIColor.white
        

        
        addSubview(tabBar)
        tabBar.setItems([partnershipNavBtn, homeTabItem, transactionsTabItem], animated: true)
        tabBar.selectedItem = homeTabItem

        tabBar.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
