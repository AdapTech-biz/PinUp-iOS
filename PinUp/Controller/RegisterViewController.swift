//
//  RegisterViewController.swift
//  PinUp
//
//  Created by Xavier Davis on 8/17/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import FirebaseAuth
import SwiftyJSON

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    weak var firstNameText : UITextField!
    weak var lastNameText : UITextField!
    weak var emailText : UITextField!
    weak var birthDateText : UITextField!
    weak var passwordText : UITextField!
    weak var submitBtn : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameText = registerView.firstNameText
        lastNameText = registerView.lastNameText
        emailText = registerView.emailText
        birthDateText = registerView.birthDateText
        passwordText = registerView.passwordText
        submitBtn = registerView.submitBtn
        
        view.addSubview(registerView)
        registerView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview()
        }
        

        submitBtn.addTarget(self, action: #selector(submitBtnPressed), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func submitBtnPressed(){
        print("Submit pressed...")
        let firstName = firstNameText.text!
        let lastName = lastNameText.text!
        let birthDate = birthDateText.text!
        let email = emailText.text!
        
        Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (result, error) in
            
            
            
            if error != nil {
                
                print(error)
                return
                
            }else{
                result?.user.getIDTokenForcingRefresh(true, completion: { (token, error) in
                    DispatchQueue.global(qos: .background).async {
                        guard let token = token else {fatalError()}
                        let parameters = ["token": token,
                                          "fName": firstName,
                                          "lName": lastName,
                                          "DOB": birthDate,
                                          "email": email]
                        Alamofire.request("http://192.168.1.169:3000/account/signup",method: .post, parameters: parameters).responseJSON(completionHandler: { (response) in
                            switch response.result {
                            case .success(let value):
                                
                                                    let json = JSON(value)
                                                    print("JSON: \(json)")
                                //                    self.delegate?.provideUserProfile(profile: json)
                                //                    DispatchQueue.main.async {
                                //                        self.presentViewController(homeVC)
                                //                    }
                                
                            case .failure(let error):
                                print(error)
                            }
                        })
                    }
                })
            }
        }
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
