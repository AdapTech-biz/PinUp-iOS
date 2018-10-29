//
//  LogInViewController.swift
//  PinUp
//
//  Created by Xavier Davis on 5/21/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import FirebaseAuth
import FirebaseStorage
import SVProgressHUD
import SnapKit
import Spring
import RxCocoa
import RxSwift
import RxKeyboard

protocol FetchProfileProtocol {
    func provideUserProfile(profile: JSON)
}

class LogInViewController: UIViewController {
    
    
    //    var userProfile : JSON?
    var storage : Storage?
    var storageRef : StorageReference?
    
    var logInView = LogInView()
    
    weak var emailTextField : SpringTextField!
    weak var passwordTextField : SpringTextField!
    weak var createNewAccountBtn : SpringButton!
    weak var logInBtn : SpringButton!
    var delegate : FetchProfileProtocol?
    
    var textFieldEdits = (username: false, password: false)
    let disposableBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField = logInView.emailTextField
        emailTextField.delegate = self
        passwordTextField = logInView.passwordTextField
        passwordTextField.delegate = self
        createNewAccountBtn = logInView.newAccountButton
        logInBtn = logInView.logInBtn
        
        let logInBtnPressed = logInBtn.rx.tap
        logInBtnPressed.asDriver().drive(onNext: { (tap) in
            self.logInBtnPressed()
        }).disposed(by: disposableBag)
        
        let registerBtnPressed = createNewAccountBtn.rx.tap
        registerBtnPressed.asDriver().drive(onNext: { (tap) in
            print("New User Tapped")
            self.registerUserPressed()
        }).disposed(by: disposableBag)
        
        
        view.addSubview(logInView)
        logInView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview()
        }
        
        
        emailTextField.setupAnimation(.fadeInDown, viewToAnimate: emailTextField, duration: 2.0, delay: 0)
        
        
        passwordTextField.setupAnimation(.fadeInDown, viewToAnimate: passwordTextField, duration: 2.0, delay: 0.4)
        
        emailTextField.animate()
        
        passwordTextField.animate()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func logInBtnPressed() {
        SVProgressHUD.show()
        logInView.alpha = 0.3
        //        let homeVC = HomeViewController()
        //        self.present(homeVC, animated: true, completion: {
        //            SVProgressHUD.dismiss()
        //            self.logInView.alpha = 1.0
        //
        //
        //        })
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        authUser(email: email, password: password)
        
    }
    
    func registerUserPressed(){
        let registerVC = RegisterViewController()
        present(registerVC, animated: true, completion: nil)
    }
    
    func authUser(email: String, password: String){
        DispatchQueue.global(qos: .background).async {
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if let user = result?.user{
                    //                            userProfile.email = user.email!
                    user.getIDTokenForcingRefresh(true, completion: { (token, error) in
                        if let token = token{
//                            print("Current Token: \(token)")
                            self.getProfileFromServer(userToken: token)
                        }else{
                            print("No token given")
                        }
                    })
                    
                }else{
                    print(error?.localizedDescription as Any)
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.logInView.alpha = 1.0
                        self.logInBtn.backgroundColor = UIColor.red
                        self.logInBtn.setupAnimation(.shake, viewToAnimate: self.logInBtn, duration: 1.0, delay: 0)
                        
                        self.logInBtn.animateToNext(completion: {
                            self.logInBtn.backgroundColor = UIColor.blue
                        })
                    }
                    
                }
                
                
            }
        }
        
    }
    
    func getProfileFromServer(userToken token: String){
        
        let homeVC = HomeViewController()
        self.delegate = homeVC
        
        DispatchQueue.global(qos: .background).async {
            
            Alamofire.request("http://192.168.1.169:3000/profile/generateProfile",method: .post ,parameters: ["token" : token]).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    print(json)
//                    print("JSON: \(json["picture"]["data"])")
                    self.delegate?.provideUserProfile(profile: json)
                    DispatchQueue.main.async {
                    self.presentViewController(homeVC)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            })
        }
        
    }
    
    
    
    func checkPopulatedTextFields() {
        
        if textFieldEdits.password && textFieldEdits.username{
            logInBtn.setupAnimation(.slideUp, viewToAnimate: logInBtn, duration: 1.0, delay: 0)
            logInBtn.alpha = 1.0
            logInBtn.animate()
            textFieldEdits.password = false
            textFieldEdits.username = false
        }
    }
    
    func presentViewController(_ viewController: UIViewController){
        
            present(viewController, animated: true, completion: {
                SVProgressHUD.dismiss()
            })
    }
}

extension LogInViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            textFieldEdits.username = true
        default:
            textFieldEdits.password = true
        }
        checkPopulatedTextFields()
    }
}

extension Springable{
    func setupAnimation(_ animationType : AnimationName, viewToAnimate view: Springable, duration: CGFloat, delay: CGFloat){
        
        view.animation = animationType.rawValue
        view.delay = delay
        view.duration = duration
    }
}

