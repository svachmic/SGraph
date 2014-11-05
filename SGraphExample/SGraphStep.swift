//
//  SGraphStep.swift
//  SGraphExample
//
//  Created by Michal Švácha on 22/10/14.
//  Copyright (c) 2014 Michal Švácha. All rights reserved.
//

import UIKit

class SGraphStep: NSObject {
    var from:SNode?
    var to:SNode?
    var length:Int?
    
    override var description : String {
        return "\n From \(from!.nodeID) leading to \(to!.nodeID) with length \(length)"
    }
}
