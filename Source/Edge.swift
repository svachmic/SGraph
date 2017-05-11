//
//  SEdge.swift
//  SGraphExample
//
//  Created by Michal Švácha on 22/10/14.
//  Copyright (c) 2014 Michal Švácha. All rights reserved.
//

import Foundation

class SEdge {
    var destination: SNode
    var length: Int
    var edgeID: Int
    
    init(destination: SNode, length: Int, edgeID: Int) {
        self.destination = destination
        self.length = length
        self.edgeID = edgeID
    }
}
