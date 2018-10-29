//
//  LogInView.swift
//  PinUp
//
//  Created by Xavier Davis on 8/5/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Spring

struct IconDesign {
    let size = (width: 156, height: 148)
    let image : UIImage = #imageLiteral(resourceName: "LogIn_Icon")
    let offsetFromTop = 90
}

struct TextFieldDesign{
    let size = (width: 265, height: 64)
    
}

struct ButtonDesign {
    let fontsize = UIFont.buttonFontSize
    }

struct LabelHeaderDesign {
    let fontSize = UIFont.labelFontSize + 20
}

class LogInView: UIView{
    
    let screenSize = UIScreen.main.bounds
    let logoImageView : UIImageView
    let loginLabel : UILabel
    let emailTextField : SpringTextField
    let passwordTextField : SpringTextField
    let newAccountButton : SpringButton
    let logInBtn : SpringButton
  
    
    override init(frame: CGRect) {
        
        let iconDesign = IconDesign()
        let labelHeaderDesign = LabelHeaderDesign()
        let textFieldDesign = TextFieldDesign()
        

        self.logoImageView = {
                let view = UIImageView()
                view.image = iconDesign.image
                view.contentMode = .scaleAspectFit
                
                
                return view
            }()
        

        self.loginLabel = {
                let labelView = UILabel()
                labelView.text = "Log In"
                labelView.font = labelView.font.withSize(labelHeaderDesign.fontSize)
                
                return labelView
            }()
        

        
        self.emailTextField = {
                let textField = SpringTextField()
                textField.tag = 1
                
                textField.backgroundColor = UIColor.blue
                textField.borderStyle = .roundedRect
                textField.placeholder = "Username"
                
                return textField
            }()
        

            self.passwordTextField = {
                let textField = SpringTextField()
                textField.tag = 2
                textField.backgroundColor = UIColor.blue
                textField.borderStyle = .roundedRect
                textField.placeholder = "Password"
                
                return textField
            }()
        

       
   
            self.newAccountButton = {
                let button = SpringButton()
                
                button.setTitle("New Account?", for: .normal)
                button.backgroundColor = UIColor.clear
                button.setTitleColor(UIColor.blue, for: .normal)
                
                return button
            }()
        
        
        self.logInBtn = {
                let button = SpringButton()
                
                button.setTitle("Log In", for: .normal)
                button.setTitleColor(UIColor.green, for: .normal)
                button.backgroundColor = UIColor.blue
                button.titleLabel?.font = button.titleLabel?.font.withSize(UIFont.buttonFontSize)
                button.alpha = 0.0
                
                return button
            }()
        
//        self.registerUserBtn = {
//           let button = SpringButton()
//            button.setTitle("New User?", for: .normal)
//            return button
//        }()
        
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        addSubview(self.logoImageView)
        addSubview(self.loginLabel)
        addSubview(self.emailTextField)
        addSubview(self.passwordTextField)
        addSubview(self.newAccountButton)
        addSubview(self.logInBtn)
        
        
        logoImageView.snp.makeConstraints { (make) in
            make.height.equalTo(iconDesign.size.height)
            make.width.equalTo(iconDesign.size.width)
            make.top.equalToSuperview().offset(iconDesign.offsetFromTop)
            make.centerX.equalToSuperview()
        }
        
        loginLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.centerX.equalTo(logoImageView)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.height.equalTo(textFieldDesign.size.height)
            make.width.equalTo(textFieldDesign.size.width)
            make.top.equalTo(loginLabel.snp.bottom).offset(80)
            make.centerX.equalTo(logoImageView)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(textFieldDesign.size.height)
            make.width.equalTo(textFieldDesign.size.width)
            make.top.equalTo(emailTextField.snp.bottom).offset(42)
            make.centerX.equalTo(emailTextField)
        }
        
        newAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.centerX.equalTo(passwordTextField)
            
        }
        
        logInBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(newAccountButton.snp.bottom).offset(76)
            make.height.equalTo(73)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Failed to init coder")
    }
}
