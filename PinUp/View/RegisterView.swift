//
//  RegisterView.swift
//  PinUp
//
//  Created by Xavier Davis on 8/17/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class RegisterView: UIView{
    
    var scrollView : UIScrollView
    var scrollableView : UIView
    var firstName : UILabel
    var lastName : UILabel
    var birthDate : UILabel
    var emailLabel : UILabel
    var firstNameText : UITextField
    var lastNameText : UITextField
    var emailText : UITextField
    var birthDateText : UITextField
    var passwordLabel : UILabel
    var passwordText : UITextField
    var submitBtn : UIButton
    
    override init(frame: CGRect) {
        
        scrollView = {
           let scrollView = UIScrollView()
            
            return scrollView
        }()
        
        scrollableView = {
            let view = UIView()
            
            return view
        }()
        
        firstName = {
           let label = UILabel()
            label.text = "First Name"
            
            return label
        }()
        
        lastName = {
           let label = UILabel()
            label.text = "Last Name"
            return label
        }()
        
        emailLabel = {
            let label = UILabel()
            label.text = "Email"
            return label
        }()
        
        birthDate = {
            let label = UILabel()
            label.text = "Date of Birth"
            return label
        }()
        
        firstNameText = {
           let textField = UITextField()
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        lastNameText = {
           let textField = UITextField()
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        emailText = {
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        birthDateText = {
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        passwordLabel = {
            let label = UILabel()
            label.text = "Password"
            return label
        }()
        
        passwordText = {
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        submitBtn = {
            let button = UIButton()
            button.setTitle("Submit", for: .normal)
            button.backgroundColor = UIColor.blue
            
            
            return button
        }()
 
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        scrollView.addSubview(firstName)
        scrollView.addSubview(lastName)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(birthDate)
        scrollView.addSubview(firstNameText)
        scrollView.addSubview(lastNameText)
        scrollView.addSubview(emailText)
        scrollView.addSubview(birthDateText)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordText)
        addSubview(submitBtn)
//        scrollView.addSubview(scrollableView)
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(submitBtn.snp.top)
        }
//        scrollableView.snp.makeConstraints { (make) in
//            make.top.left.right.equalToSuperview()
//            make.height.equalTo(800)
//            make.width.equalToSuperview()
//        }
        
        firstName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        firstNameText.snp.makeConstraints { (make) in
            make.centerX.equalTo(firstName)
            make.top.equalTo(firstName.snp.bottom).offset(5)
            make.width.equalTo(150)
        }
        
        lastName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstNameText.snp.bottom).offset(30)
        }
        lastNameText.snp.makeConstraints { (make) in
            make.centerX.equalTo(lastName)
            make.top.equalTo(lastName.snp.bottom).offset(5)
            make.width.equalTo(150)
        }
        
        emailLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(lastNameText.snp.bottom).offset(30)
        }
        
        emailText.snp.makeConstraints { (make) in
            make.centerX.equalTo(emailLabel)
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
            make.width.equalTo(150)
        }
        
        birthDate.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailText.snp.bottom).offset(30)
        }
        
        birthDateText.snp.makeConstraints { (make) in
            make.centerX.equalTo(birthDate)
            make.top.equalTo(birthDate.snp.bottom).offset(5)
            make.width.equalTo(150)
        }
        
        passwordLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(birthDateText.snp.bottom).offset(30)
        }
        
        passwordText.snp.makeConstraints { (make) in
            make.centerX.equalTo(passwordLabel)
            make.top.equalTo(passwordLabel.snp.bottom).offset(5)
            make.width.equalTo(150)
        }
        
        submitBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
