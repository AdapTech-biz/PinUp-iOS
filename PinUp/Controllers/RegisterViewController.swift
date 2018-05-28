//
//  RegisterViewController.swift
//  PinUp
//
//  Created by Xavier Davis on 5/16/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseAuth
import SwiftyJSON
import SVProgressHUD

class RegisterViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordReEnterTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
//    let URL = "http://ec2-54-85-216-19.compute-1.amazonaws.com/"
   let datePicker = UIDatePicker()
    var birthDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateOfBirthTextField.inputAccessoryView = toolbar
        dateOfBirthTextField.inputView = datePicker
        
        let tapGesture  = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        scrollView.addGestureRecognizer(tapGesture)
        
        
        // Adjust text field when keyboard toggles
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Set up keyboard function
    /////////////////////////////////////////
    
    @objc func closeKeyboard()  {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        dateOfBirthTextField.text = formatter.string(from: datePicker.date)
        birthDate = datePicker.date
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    ////////////////////////////////////////
    
   
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        SVProgressHUD.show()
//        let URL_PATH = URL + "account/signup"
        let firstName = firstNameTextField.text!
        let lastName  = lastNameTextField.text!
        let email = emailTextField.text!
        let password = passwordReEnterTextField.text!
        Auth.auth().createUser(withEmail: email, password: password) { (firebaseResult, error) in

                if let user = firebaseResult?.user{
                    
                    user.sendEmailVerification(completion: { (error) in
                        if error != nil{
                            print(error?.localizedDescription)
                        }
                    })
                    
                    user.getIDTokenForcingRefresh(true, completion: { (idToken, error) in
                        if error != nil{
                            print(error?.localizedDescription)
                        }else{
                            
                            let param : [String: Any] = ["firstName": firstName,
                                                         "lastName": lastName,
                                                         "email": email,
                                                         "DOB": self.birthDate,
                                                         "idToken": idToken!]
                            Alamofire.request("http://192.168.1.169:3000/account/signup", method: .post, parameters: param).responseJSON(completionHandler: { (data) in
                                if data.result.isSuccess{
                                    print("Sucessful, created profile!")
                                    
                                    let profile : JSON = JSON(data.result.value!)   //set the variable to the JSON value -- needed to unwrap the optional and cast to JSON
                                    print(profile)
                                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                    changeRequest?.displayName = profile["_id"].stringValue
                                    changeRequest?.commitChanges { (error) in
                                        if error != nil{
                                            print(error?.localizedDescription)
                                        }
                                        SVProgressHUD.dismiss()
                                            self.performSegue(withIdentifier: "registerToProfile", sender: self)
                                    }
                                    
                                    
                                   
                                }else{
                                    
                                    print("Error \(data.result.error)")
                                   
                                }
                            })
                        }
                    })
                    

                }else{
                     print(error?.localizedDescription)
                }
        
        }

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ProfileViewController
        
        guard let user = Auth.auth().currentUser else {fatalError()}
        let params : [String : String] = ["id" : user.displayName!]
        Alamofire.request("http://192.168.1.169:3000/profile/\(user.displayName!)", method: .get).responseJSON(completionHandler: { (data) in
            if data.result.isSuccess{
                //                            print("Sucessful, Got weather data!")
                
                let profile : JSON = JSON(data.result.value!)   //set the variable to the JSON value -- needed to unwrap the optional and cast to JSON
                print(profile)
                
                destinationVC.user.firstName = profile["firstName"].stringValue
                destinationVC.user.lastName = profile["lastName"].stringValue
                
            }else{
                
                print("Error \(data.result.error)")
                
            }
            
        })
        
    }

}
