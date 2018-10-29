//
//  CollectionViewCell.swift
//  PinUp
//
//  Created by Xavier Davis on 8/5/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var placeholderLabel : UILabel
    var coinImageView : UIImageView
    var cellBackgroundImageView : UIImageView
    var payoutAmountLabel : UILabel
    var taskCreatorLabel : UILabel
    
    override init(frame: CGRect) {
        placeholderLabel = UILabel()
        placeholderLabel.text = "Title For Task"
        
        coinImageView = UIImageView()
        coinImageView.image = #imageLiteral(resourceName: "coins-stack")
        
        cellBackgroundImageView = UIImageView()
        cellBackgroundImageView.image = #imageLiteral(resourceName: "Task_Card_Image")
        cellBackgroundImageView.contentMode = .scaleAspectFit
        
        payoutAmountLabel = UILabel()
        payoutAmountLabel.text = "999"
        
        taskCreatorLabel = UILabel()
        taskCreatorLabel.text = "Davis, X"
        
        
        super.init(frame: frame)
        backgroundView = UIView(frame: frame)
        backgroundView?.addSubview(cellBackgroundImageView)
        backgroundView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        contentView.addSubview(placeholderLabel)
        contentView.addSubview(coinImageView)
        contentView.addSubview(payoutAmountLabel)
        contentView.addSubview(taskCreatorLabel)
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(25)
        }
        
        payoutAmountLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(35)
        }
        
        coinImageView.snp.makeConstraints { (make) in
           make.left.equalTo(payoutAmountLabel.snp.right).offset(5)
            make.bottom.equalTo(payoutAmountLabel)
        }
        
        taskCreatorLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
       
        
        cellBackgroundImageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()

        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
