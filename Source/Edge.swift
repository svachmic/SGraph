//
//  Edge.swift
//  SwiftGraph
//
//  Created by Michal Švácha on 22.10.14.
//  Copyright © 2017 Michal Svacha. All rights reserved.
//

import Foundation

class Edge {
    var destination: Node
    var length: Int
    var edgeID: Int
    
    init(destination: Node, length: Int, edgeID: Int) {
        self.destination = destination
        self.length = length
        self.edgeID = edgeID
    }
}
