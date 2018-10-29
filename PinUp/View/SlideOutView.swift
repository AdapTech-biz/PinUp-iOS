//
//  SlideOutView.swift
//  PinUp
//
//  Created by Xavier Davis on 8/11/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SlideOutView : UIView{
    var profileImageView : UIImageView
    var userName : UILabel
    var signOutBtn : UIButton
    
     override init(frame: CGRect) {
        
        profileImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = #imageLiteral(resourceName: "Rick")
            return imageView
        }()
        
        userName = {
            let labelView = UILabel()
            labelView.text = "Xavier"
            labelView.font = labelView.font.withSize(UIFont.labelFontSize)
            
            return labelView
        }()
        
        signOutBtn = {
            let button = UIButton()
            
            button.setTitle("Sign Out", for: .normal)
            button.backgroundColor = UIColor.clear
            button.setTitleColor(UIColor.blue, for: .normal)
            
            return button
        }()
        
        super.init(frame: frame)
        backgroundColor = UIColor.brown
        addSubview(profileImageView)
        addSubview(userName)
        addSubview(signOutBtn)
        alpha = 0.0
        
        profileImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.height.width.equalTo(150)
        }
        
        userName.snp.makeConstraints { (make) in
            make.centerX.equalTo(profileImageView)
            make.top.equalTo(profileImageView.snp.bottom).offset(15)
        }
        
        signOutBtn.snp.makeConstraints { (make) in
            make.centerX .equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
