//
//  User.swift
//  PinUp
//
//  Created by Xavier Davis on 5/25/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import Foundation
import UIKit


class UserProfile{
    var firstName : String = ""
    var lastName : String = ""
    var email : String = ""
    var DOB :  Date
    var wallet : String = ""
    var balance : Double = 0.00
    var privateKey : String = ""
    var counterParts = [UserProfile]()
    var createdTask = [Task]()
    var acceptedTask = [Task]()
    var pendingTask = [Task]()
    var profileImage = UIImage()
    
    
    init() {
        DOB = Date()
    }

}
