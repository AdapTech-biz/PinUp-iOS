//
//  ProfileViewController.swift
//  PinUp
//
//  Created by Xavier Davis on 5/21/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
//    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let imagePicker = UIImagePickerController()
    var user = UserProfile()
    let storage = Storage.storage()
    var storageRef : StorageReference?
    


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageRef = storage.reference()
        profileImage.image = user.profileImage
        
        
//        tableview.delegate = self
//        tableview.dataSource = self
        imagePicker.delegate = self
//        tableview.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "taskCells")
//
        let tap = UITapGestureRecognizer(target: self, action: #selector(wasTapped))
        profileImage.addGestureRecognizer(tap)
        profileImage.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
         self.nameLabel.text = self.user.firstName
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("User signed out")
             let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let firstDisplayController : ViewController = mainStoryboard.instantiateViewController(withIdentifier: "userInitailizer") as! ViewController
        
           view.window?.rootViewController = firstDisplayController
            view.window?.makeKeyAndVisible()
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

    }
    
    @objc func wasTapped(_ sender: UITapGestureRecognizer) {
        print("Tap occured")
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        profileImage.image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        
       
        var data = NSData()
        data = UIImageJPEGRepresentation(profileImage.image!, 0.8)! as NSData
        // set upload path
        
        let filePath = "\(Auth.auth().currentUser!.uid)/\("userPhoto")"
       let userProfileRef = storageRef?.child(filePath)
        let uploadTask = userProfileRef?.putData(data as Data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            print(metadata)
//            // Metadata contains file metadata such as size, content-type.
//            let size = metadata.size
            // You can also access to download URL after upload.
            userProfileRef?.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
            print(url?.absoluteString)
            }
        }

        
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

//extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1
//        case 1:
//            return 2
//        default:
//            return 1
//        }
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0:
//            return "Created Task"
//        case 1:
//            return "Accepted Task"
//        default:
//            return "Pending Tasks"
//        }
//    }
//    
////    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
////        return ["Created Task", "Accepted Task", "Pending Task"]
////    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCells", for: indexPath) as! TableViewCell
//        cell.taskTitle.text = "New cell title"
//        cell.payoutAmount.text = "10.00"
//        
//        return cell
//        
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return 155.0;//Choose your custom row height
//    }
//    
//    
//    
//    
//}
