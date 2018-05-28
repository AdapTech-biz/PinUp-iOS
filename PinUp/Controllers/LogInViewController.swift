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


class LogInViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var userProfile : JSON?
    var storage : Storage?
    var storageRef : StorageReference?
    var image = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture  = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tapGesture)
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: username.text!, password: password.text!) { (result, error) in

            if let user = result?.user{
                
                self.storage = Storage.storage()
                self.storageRef = self.storage?.reference()
                let filePath = "\(Auth.auth().currentUser!.uid)/\("userPhoto")"
                let userProfileRef = self.storageRef?.child(filePath)
                
                Alamofire.request("http://192.168.1.169:3000/profile/\(user.displayName!)", method: .get).responseJSON(completionHandler: { (data) in
                if data.result.isSuccess{
                    
                    let profile : JSON = JSON(data.result.value!)   //set the variable to the JSON value -- needed to unwrap the optional and cast to JSON
                    print(profile)
                    self.userProfile = profile
                    
                    
                }else{
                    
                    print("Error \(data.result.error)")
                    
                }
                    
                    userProfileRef?.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if let error = error {
                            // Uh-oh, an error occurred!
                            print(error)
                        } else {
                            // Data for "images/island.jpg" is returned
                            self.image = UIImage(data: data!)!
                            print(self.image)
                            
                        }
                        SVProgressHUD.dismiss()
                        self.performSegue(withIdentifier: "fromLogIntoProfile", sender: self)
                    }
                
            })
                
                
               
            }else{
                print(error?.localizedDescription as Any)
            }
          

        }

    }
    
    @objc func closeKeyboard()  {
        view.endEditing(true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ProfileViewController
        destinationVC.user.profileImage = image
        destinationVC.user.firstName = userProfile!["firstName"].stringValue

        }
        
  
    
}
