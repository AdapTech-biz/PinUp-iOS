//
//  SearchBarViewController.swift
//  PinUp
//
//  Created by Xavier Davis on 10/27/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit

class SearchBarViewController: UIViewController {
    var searchBarView = SearchBarView()
    var searchTextField : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField = searchBarView.searchTextField
        searchTextField.delegate = self
        addView()

        // Do any additional setup after loading the view.
    }
    
    func addView(){
        view.addSubview(searchBarView)
        searchBarView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
extension SearchBarViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print (textField.text!)
    }
    
    
}
