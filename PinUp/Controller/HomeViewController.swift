//
//  HomeViewController.swift
//  PinUp
//
//  Created by Xavier Davis on 8/5/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import SwiftyJSON
import FirebaseAuth
import Alamofire



class HomeViewController: UIViewController {
    let homeView = BottomNavView()
    var slideOutView : SlideOutView!
//    var collectionView : UICollectionView!
    weak var userProfile = UserProfile()
//    var taskSwitcher : UISegmentedControl!
    var bottomNavView : UITabBar!
    var settingsBtn : UIButton!
    var signOutBtn : UIButton!
    var profileImageView : UIImageView!
    var json : JSON!
    var innerView : UIView!
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
// let taskListViewController = TaskListViewController()
//        let newView = taskListViewController.view
//        homeView.innerView = newView!
//        view.addSubview(homeView)
//        homeView.innerView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
       
        
        

//        collectionView = homeView.collectionView
//        settingsBtn = homeView.settingsBtn
//        taskSwitcher = homeView.taskSwitcher
//        slideOutView = homeView.slideOutView
        signOutBtn = slideOutView.signOutBtn
        profileImageView = slideOutView.profileImageView
//        bottomNavView = homeView.bottomNavView
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.contentInset = UIEdgeInsets.init(top: 40.0, left: 10.0, bottom: 10.0, right: 10.0)
        signOutBtn.addTarget(self, action: #selector(signOutPressed), for: .touchUpInside)
    
        view.addSubview(homeView)
        homeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        innerView = homeView.innerView
        
        

//        taskSwitcher.addTarget(self, action: #selector(segmentControlPressed), for: .valueChanged)
        settingsBtn.addTarget(self, action: #selector(settingsBtnPressed), for: .touchUpInside)
        let guesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(guesture)
        profileImageView.isUserInteractionEnabled = true
        
        bottomNavView.delegate = self
        // Do any additional setup after loading the view.
    }

    @objc func profileImageTapped(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
        print("tapped..")
    }
    
    @objc func settingsBtnPressed(){

        
//            self.homeView.showSlideOut()
        
    }
    
    
//    @objc func segmentControlPressed(){
//        switch taskSwitcher.selectedSegmentIndex{
//        case 0:
//            print("Created Tasks")
//            UIView.animate(withDuration: 0.5, animations: {
//                self.homeView.collectionView.backgroundColor = UIColor.clear
//                })
//        default:
//            print("Accepted Task")
//            UIView.animate(withDuration: 0.5, animations: {
//                self.homeView.collectionView.backgroundColor = UIColor.blue
//                })
//        }
//    }
    
    @objc func signOutPressed(){
        print("Sign out...")
        
        try? Auth.auth().signOut()
        
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("goodbye")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func uploadPictureToServer(_ imageData: Data){
        
        
//        print(strBase64)
        
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: { (token, error) in
            
            if let token = token{
                DispatchQueue.global(qos: .background).async {
//                     let imageData = UIImagePNGRepresentation(image)!
                    let parameters : [String : Any] = ["token": token,
                                      "uploadedImage": imageData]
                    
                    
                    Alamofire.request("http://192.168.1.169:3000/profile/uploadProfilePicture",method: .post ,parameters: parameters).responseJSON(completionHandler: { (response) in
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            print(json)


                        case .failure(let error):
                            print(error)
                        }
                    })
                }
            }
            
        })
        
    }
}

//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        switch collectionView.indexPathsForSelectedItems?.first {
//        case .some(indexPath):
//            return CGSize(width: collectionView.frame.width-20, height: 400) // your selected height
//        default:
//           return CGSize(width: collectionView.frame.width-20, height: 246)
//        }
//        
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//       collectionView.performBatchUpdates(nil, completion: nil)
//    
//    }
//
//}

extension HomeViewController: FetchProfileProtocol{
    func provideUserProfile(profile: JSON) {
        self.json = profile
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            // imageViewPic.contentMode = .scaleToFill
//            profileImageView.image = pickedImage
//            
//            let imageData : Data = UIImageJPEGRepresentation(pickedImage, 0.5)!
//            print(imageData.base64EncodedData())
//            uploadPictureToServer(imageData.base64EncodedData())
//            
//
//            
//        }
//        picker.dismiss(animated: true, completion: nil)
//        
//        
//    }
}

extension HomeViewController: UITabBarDelegate{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    
        switch item.title! {
        case "Transactions":
           let newView = MinimumView()
            view.addSubview(newView)
           newView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            }
        default:
            print("other")
        }
    }
}



