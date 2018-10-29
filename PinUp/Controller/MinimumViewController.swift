//
//  MinimumViewController.swift
//  PinUp
//
//  Created by Xavier Davis on 10/22/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit

class MinimumViewController: UIViewController {
    let minimumView = MinimumView()
    var sendPaymentBtn : UIButton!
    var requestPaymentBtn : UIButton!
    var currentBalence : Int = 0
    var balenceLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        view.addSubview(minimumView)
        sendPaymentBtn = minimumView.sendPaymentBtn
        requestPaymentBtn = minimumView.requestPaymentBtn
        balenceLabel = minimumView.currentBalence
        currentBalence = Int(minimumView.currentBalence.text!) ?? 0
        
        minimumView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview()
        }

        sendPaymentBtn.addTarget(self, action: #selector(sendPaymentBtnPressed), for: .touchUpInside)
        requestPaymentBtn.addTarget(self, action: #selector(requestPaymentBtnPressed), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    

    @objc func sendPaymentBtnPressed(){
        print("Send")
        currentBalence = currentBalence - 10
        balenceLabel.text = "\(currentBalence)"
    }
    
    @objc func requestPaymentBtnPressed(){
        print("Request")
        currentBalence = currentBalence + 10
        balenceLabel.text = "\(currentBalence)"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
