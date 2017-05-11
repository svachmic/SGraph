//
//  Graph.swift
//  SwiftGraph
//
//  Created by Michal Švácha on 19.10.14.
//  Copyright © 2017 Michal Svacha. All rights reserved.
//

import Foundation

/// Struct representing one movement in a sequence, such as path.
public struct GraphStep {
    public var from: Node
    public var to: Node
    public var length: Int
    
    public var description: String {
        return "From \(from.nodeID) leading to \(to.nodeID) with length \(length)"
    }
}

/// Class representing the whole graph. Holds edges and nodes.
public class Graph {
    public var root: Node?
    public var edges = [Node: [Edge]]()
    public var nodes: Set<Node> = []
    
    /// Public empty initializer.
    public init() { }
    
    /// Adds a unidirectional edge between given nodes to the graph.
    ///
    /// - Parameter from: Starting node.
    /// - Parameter to: Ending node.
    /// - Parameter edgeID: Optional Integer object. Used for bidirectional edge purposes (same ID).
    public func addEdge(from: Node, to: Node, edgeID: Int? = nil) {
        root = root ?? from
        
        let newEdge = Edge(destination: to, length: 1, edgeID: edgeID ?? edges.count)
        
        if let destinations = edges[from] {
            edges[from] = destinations + [newEdge]
        } else {
            edges[from] = [newEdge]
        }
    }
    
    /// Adds a bidirectional edge between two nodes. Uses internally addEdge method but sends in the same ID for two edges.
    ///
    /// - Parameter from: Starting node and vice versa.
    /// - Parameter to: Ending node and vice versa.
    public func addBidirectionalEdge(from: Node, to: Node) {
        let edgeID = edges.count
        addEdge(from: from, to: to, edgeID: edgeID)
        addEdge(from: to, to: from, edgeID: edgeID)

        add(node: from)
        add(node: to)
    }
    
    /// Adds a node to the graph. Also initializes the array of outbound edges. ID must be unique.
    ///
    /// - Parameter node: New node to be added.
    public func add(node: Node) {
        nodes.insert(node)
        
        if edges[node] == nil {
            edges[node] = []
        }
    }
    
    /// Finds a node for a given ID.
    ///
    /// - Parameter nodeID: Integer value which represents the node's ID.
    /// - Returns: Node object if found, otherwise nil.
    public func node(with nodeID: Int) -> Node? {
        for (key, _) in edges where key.nodeID == nodeID {
            return key
        }
        
        return nil
    }
    
    /// Returns the length of an edge given the endpoints. If no edge sits between, Int.max value is returned.
    ///
    /// - Parameter from: Starting node.
    /// - Parameter to: Ending node.
    /// - Returns: Integer value representing the length.
    private func edgeLength(from: Node, to: Node) -> Int {
        let result = edges[from]!.filter({ $0.destination.nodeID == to.nodeID })
        return result.count == 0 ? Int.max : result[0].length
    }
    
    /// Finds the shortest path between given nodes.
    ///
    /// - Parameter from: Starting node.
    /// - Parameter to: End node.
    /// - Returns: Optional array with GraphStep objects. Nil if path has not been found.
    public func shortestPath(from: Node, to: Node) -> [GraphStep]? {
        var keys = Set<Node>(self.nodes)
        var distances = [Int](repeating: Int.max, count: keys.count)
        var previous = [Int](repeating: Int.max, count: keys.count)
        
        distances[from.nodeID] = 0
        var u = from
        
        while keys.count > 0 {
            for edge in self.edges[u]! {
                let distance = distances[u.nodeID] + edge.length
                if distance < distances[edge.destination.nodeID] {
                    distances[edge.destination.nodeID] = distance
                    previous[edge.destination.nodeID] = u.nodeID
                }
            }
            
            keys.remove(u)
            
            if keys.count > 0 {
                u = keys.reduce(keys.first!) {
                    return distances[$0.nodeID] < distances[$1.nodeID] ? $0 : $1
                }
            }
        }
        
        var steps: [GraphStep]? = []
        var previousIndex = to.nodeID
        
        while previousIndex != from.nodeID {
            if previous[previousIndex] == Int.max {
                steps = nil
                break
            }
            
            let from = node(with: previous[previousIndex])
            let to = node(with: previousIndex)
            let step = GraphStep(
                from: from!,
                to: to!,
                length: distances[edgeLength(from: from!, to: to!)])
            steps!.insert(step, at: 0)
            
            previousIndex = previous[previousIndex]
        }
        
        return steps
    }
}
