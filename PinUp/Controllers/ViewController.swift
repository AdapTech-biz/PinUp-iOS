//
//  ViewController.swift
//  PinUp
//
//  Created by Xavier Davis on 5/16/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit
import FirebaseAuth
import Alamofire
import SwiftyJSON
import FirebaseStorage
import SVProgressHUD

class ViewController: UIViewController {
    
    var userProfile : JSON?
    var storage : Storage?
    var storageRef : StorageReference?
    var image = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if (Auth.auth().currentUser != nil){
            SVProgressHUD.show()
            
            storage = Storage.storage()
            storageRef = storage?.reference()
            
            guard let user = Auth.auth().currentUser else {fatalError()}
            
            // Create a reference to the file you want to download
            let filePath = "\(Auth.auth().currentUser!.uid)/\("userPhoto")"
            let userProfileRef = storageRef?.child(filePath)
            
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            
            
            
            Alamofire.request("http://192.168.1.169:3000/profile/\(user.displayName!)", method: .get).responseJSON(completionHandler: { (data) in
                if data.result.isSuccess{
                    
                   
                    
                    
                    let profile : JSON = JSON(data.result.value!)   //set the variable to the JSON value -- needed to unwrap the optional and cast to JSON
                    self.userProfile = profile
                   

                    
                }else{
                    
                    print("Error \(data.result.error)")
                    
                }
                
                userProfileRef?.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        // Uh-oh, an error occurred!
                    } else {
                        // Data for "images/island.jpg" is returned
                        print(data)
                        self.image = UIImage(data: data!)!
                        print(self.image)
                        
                    }
                    SVProgressHUD.dismiss()
                     self.performSegue(withIdentifier: "mainToProfile", sender: self)
                }
                
            })

    }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mainToProfile"){
        let destinationVC = segue.destination as! ProfileViewController
//            print(image)
            destinationVC.user.profileImage = image
            destinationVC.user.firstName = self.userProfile!["firstName"].stringValue

        
       
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
}

