//
//  Task.swift
//  PinUp
//
//  Created by Xavier Davis on 5/25/18.
//  Copyright © 2018 Xavier Davis. All rights reserved.
//

import Foundation

struct Task{
    var title = ""
    var description = ""
    var dateCreated = Date()
    var creator : UserProfile?
    var acceptor : UserProfile?
    var payoutAmount = 0.00
    
}
