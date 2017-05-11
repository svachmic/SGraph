//
//  SEdge.swift
//  SGraphExample
//
//  Created by Michal Švácha on 22/10/14.
//  Copyright (c) 2014 Michal Švácha. All rights reserved.
//

import UIKit

class SEdge: NSObject {
    var destinationNode:SNode
    var length:Int
    var edgeID:Int
    
    init(destination:SNode, lng:Int, edgeId:Int) {
        destinationNode = destination
        length = lng
        edgeID = edgeId
    }
}
