//
//  SearchBarView.swift
//  PinUp
//
//  Created by Xavier Davis on 10/27/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import Foundation
import UIKit

class SearchBarView : UIView{
    let screenSize = UIScreen.main.bounds
    var searchView : UIView
    var searchTextField : UITextField
    var settingsBtn : UIButton
    var searchIcon : UIImageView
    
    
    override init(frame: CGRect) {
        searchView = {
            let view = UIView()
            view.backgroundColor = UIColor.blue
            return view
        }()
        
        
        settingsBtn = {
            let buttonView = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            buttonView.setImage(#imageLiteral(resourceName: "settings_Btn"), for: .normal)
            //            buttonView.imageView?.image = #imageLiteral(resourceName: "settings_Btn")
            buttonView.imageView?.contentMode = .scaleAspectFit
            //            imageView.image = #imageLiteral(resourceName: "settings_Btn")
            //            imageView.contentMode = .scaleAspectFit
            return buttonView
        }()
        
        searchTextField = {
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        searchIcon = {
            let imageView = UIImageView()
            imageView.image = #imageLiteral(resourceName: "search_icon")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(searchView)
        
        searchView.addSubview(searchTextField)
        searchView.addSubview(settingsBtn)
        searchTextField.addSubview(searchIcon)
        
        searchView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(screenSize.height/10)
        }
        
        settingsBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(35)
            
        }
        
        searchTextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(settingsBtn.snp.left).offset(-40)
        }
        
        searchIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
