//
//  SNode.swift
//  SGraphExample
//
//  Created by Michal Švácha on 19/10/14.
//  Copyright (c) 2014 Michal Švácha. All rights reserved.
//

import Foundation

class SNode: Hashable, Equatable {
    var isTraversed:Bool = false
    var nodeID: Int
    
    init(nodeId:Int) {
        nodeID = nodeId
    }
    
    var hashValue: Int {
        get {
            return "\(nodeID)".hashValue
        }
    }
    
    static func ==(lhs: SNode, rhs: SNode) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var description : String {
        return "\(nodeID)"
    }
}
