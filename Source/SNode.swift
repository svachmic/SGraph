//
//  SNode.swift
//  SGraphExample
//
//  Created by Michal Švácha on 19/10/14.
//  Copyright (c) 2014 Michal Švácha. All rights reserved.
//

import UIKit

class SNode: NSObject {
    var isTraversed:Bool = false
    var nodeID:Int;
    
    init(nodeId:Int) {
        nodeID = nodeId;
    }
    
    override var description : String {
        return String(nodeID)
    }
}
