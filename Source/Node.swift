//
//  Node.swift
//  SwiftGraph
//
//  Created by Michal Švácha on 19.10.14.
//  Copyright © 2017 Michal Svacha. All rights reserved.
//

import Foundation

/// Base class for a node (= vertex) in a graph.
public class Node: Hashable, Equatable {
    public var nodeID: Int
    
    public init(nodeID: Int) {
        self.nodeID = nodeID
    }
    
    public var description: String {
        return "\(nodeID)"
    }
    
    // MARK: - Hashable + Equatable methods
    
    public var hashValue: Int {
        return "\(nodeID)".hashValue
    }
    
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
