//
//  MinimumView.swift
//  PinUp
//
//  Created by Xavier Davis on 10/22/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import Foundation
import SnapKit

class MinimumView: UIView {
    
    var headerView : UIView
    var bodyView : UIView
    var userName : UILabel
    var currentBalence : UILabel
    var sendPaymentBtn : UIButton
    var requestPaymentBtn : UIButton
    
    override init(frame: CGRect) {
        
        headerView = {
          let view = UIView()
            view.backgroundColor = UIColor.blue
            return view
        }()
        
        userName = {
           let label = UILabel()
            label.text = "Xavier Davis"
            label.textColor = UIColor.white
            return label
        }()
        
        currentBalence = {
            let label = UILabel()
            label.text = "999999"
            label.textColor = UIColor.white
            return label
        }()
        
        sendPaymentBtn = {
           let button = UIButton()
            button.setTitle("Send", for: .normal)
            button.backgroundColor = UIColor.gray
            button.layer.borderColor = UIColor.blue.cgColor
            button.layer.borderWidth = 2.0
            button.layer.cornerRadius = 10.0
            return button
        }()
        
        requestPaymentBtn = {
            let button = UIButton()
            button.setTitle("Request", for: .normal)
            button.backgroundColor = UIColor.gray
            button.layer.borderColor = UIColor.blue.cgColor
            button.layer.borderWidth = 2.0
            button.layer.cornerRadius = 10.0

            return button
        }()
        
        bodyView = {
           let view = UIView()
            return view
        }()
        
        super.init(frame: frame)
        backgroundColor = UIColor.white

        
        headerView.addSubview(userName)
        headerView.addSubview(currentBalence)
        
        bodyView.addSubview(sendPaymentBtn)
        bodyView.addSubview(requestPaymentBtn)
        
        
        addSubview(headerView)
        addSubview(bodyView)
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        userName.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(20)
            
        }
        currentBalence.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-20)
        }
        
        bodyView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).inset(-30)
            make.left.right.bottom.equalToSuperview().inset(30)
            
        }
        
        sendPaymentBtn.snp.makeConstraints { (make) in
           make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
            
        }
        
        requestPaymentBtn.snp.makeConstraints { (make) in
            make.top.equalTo(sendPaymentBtn.snp.bottom).inset(-15)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
