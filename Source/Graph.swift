//
//  SGraph.swift
//  SGraphExample
//
//  Created by Michal Švácha on 19/10/14.
//  Copyright (c) 2014 Michal Švácha. All rights reserved.
//

import Foundation

struct SGraphStep {
    var from: SNode
    var to: SNode
    var length: Int
    
    var description: String {
        return "From \(from.nodeID) leading to \(to.nodeID) with length \(length)"
    }
}

class SGraph {
    var root: SNode?
    var edges = [SNode : [SEdge]]()
    var nodes: Set<SNode> = []
    
    func addEdge(from: SNode, to: SNode, edgeID: Int? = nil) {
        root = root ?? from
        
        let newEdge = SEdge(destination: to, length: 1, edgeID: edgeID ?? edges.count)
        
        if let destinations = edges[from] {
            edges[from] = destinations + [newEdge]
        } else {
            edges[from] = [newEdge]
        }
    }
    
    func addBidirectionalEdge(from: SNode, to: SNode) {
        let edgeID = edges.count
        addEdge(from: from, to: to, edgeID: edgeID)
        addEdge(from: to, to: from, edgeID: edgeID)

        add(node: from)
        add(node: to)
    }
    
    func add(node: SNode) {
        nodes.insert(node)
        
        if edges[node] == nil {
            edges[node] = []
        }
    }
    
    func node(with nodeID: Int) -> SNode? {
        for (key, _) in edges {
            if key.nodeID == nodeID {
                return key
            }
        }
        
        return nil
    }
    
    func edgeLength(from:SNode, to:SNode) -> Int {
        let result = edges[from]!.filter({ $0.destination.nodeID == to.nodeID })
        return result.count == 0 ? Int.max : result[0].length
    }
    
    func minimumSpanningTree() -> SGraph? {
        return nil
    }
    
    func eulerianPath() -> SGraph? {
        return nil
    }
    
    
    /// Finds the shortest path between given nodes.
    ///
    /// - Parameter from: Starting node.
    /// - Parameter to: End node.
    /// - Returns: Optional array with SGraphStep objects. Nil if path has not been found.
    func shortestPath(from:SNode, to:SNode) -> [SGraphStep]? {
        let keys = NSMutableSet(set: self.nodes)
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
            
            
            /*
            _ = self.edges[u]?.map({ (edge: SEdge) -> Void in
                let distance = distances[u.nodeID] + edge.length
                if distance < distances[edge.destination.nodeID] {
                    distances[edge.destination.nodeID] = distance
                    previous[edge.destination.nodeID] = u.nodeID
                }
            })*/
            
            keys.remove(u)
            
            if keys.count > 0 {
                u = keys.allObjects.reduce(keys.allObjects[0] as! SNode) {
                    return distances[$0.nodeID] < distances[($1 as! SNode).nodeID] ? ($0 as SNode) : ($1 as! SNode)
                }
            }
        }
        
        var steps: [SGraphStep]? = []
        var previousIndex = to.nodeID
        
        while previousIndex != from.nodeID {
            if previous[previousIndex] == Int.max {
                steps = nil
                break
            }
            
            let from = node(with: previous[previousIndex])
            let to = node(with: previousIndex)
            let step = SGraphStep(
                from: from!,
                to: to!,
                length: distances[edgeLength(from: from!, to: to!)])
            steps!.insert(step, at: 0)
            
            previousIndex = previous[previousIndex]
        }
        
        return steps
    }
}
