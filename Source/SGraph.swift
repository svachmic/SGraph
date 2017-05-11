//
//  SGraph.swift
//  SGraphExample
//
//  Created by Michal Švácha on 19/10/14.
//  Copyright (c) 2014 Michal Švácha. All rights reserved.
//

import Foundation

struct SGraphStep {
    var from:SNode
    var to:SNode
    var length:Int
    
    var description: String {
        return "From \(from.nodeID) leading to \(to.nodeID) with length \(length)"
    }
}

class SGraph {
    var root: SNode?
    var edges: Dictionary<SNode, [SEdge]> = Dictionary<SNode, [SEdge]>()
    var nodes:NSMutableSet = NSMutableSet()
    
    func addEdge(from: SNode, to: SNode) {
        root = root ?? from
        
        let newEdge = SEdge(destination: to, lng: 1, edgeId: 42)
        
        if let destinations = edges[from] {
            var tmp = destinations
            tmp.append(newEdge)
            edges[from] = tmp
        } else {
            var destinations = [SEdge]()
            destinations.append(newEdge)
            edges[from] = destinations
        }
    }
    
    func addBidirectionalEdge(from: SNode, to: SNode) {
        addEdge(from: from, to: to)
        addEdge(from: to, to: from)

        self.addNode(from)
        self.addNode(to)
    }
    
    func addNode(_ node:SNode) {
        nodes.add(node)
        
        if edges[node] == nil {
            let destinations = [SEdge]()
            edges[node] = destinations
        }
    }
    
    func nodeForID(_ nodeID: Int) -> SNode? {
        for (key, _) in edges {
            if key.nodeID == nodeID {
                return key
            }
        }
        
        return nil
    }
    
    func edgeLengthFor(_ from:SNode, to:SNode) -> Int {
        let result = edges[from]!.filter({ $0.destinationNode.nodeID == to.nodeID })
        return result.count == 0 ? Int.max : result[0].length
    }
    
    func minimumSpanningTree() -> SGraph? {
        return nil
    }
    
    func eulerianPath() -> SGraph? {
        return nil
    }
    
    /**
    Finds the shortest path between given nodes.
    
    :param: from Starting node.
    :param: to End node.
    :returns: Optional array with SGraphStep objects. Nil if path has not been found.
    */
    func shortestPath(from:SNode, to:SNode) -> [SGraphStep]? {
        let keys: NSMutableSet = NSMutableSet(set: self.nodes)
        var distances = [Int](repeating: Int.max, count: keys.count)
        var previous = [Int](repeating: Int.max, count: keys.count)
        distances[from.nodeID] = 0
        
        var u = from
        
        while keys.count > 0 {
            _ = self.edges[u]?.map({ (edge: SEdge) -> Void in
                let distance = distances[u.nodeID] + edge.length
                if distance < distances[edge.destinationNode.nodeID] {
                    distances[edge.destinationNode.nodeID] = distance
                    previous[edge.destinationNode.nodeID] = u.nodeID
                }
            })
            
            keys.remove(u)
            
            if keys.count > 0 {
                u = keys.allObjects.reduce(keys.allObjects[0] as! SNode) {
                    return distances[$0.nodeID] < distances[($1 as! SNode).nodeID] ? ($0 as SNode) : ($1 as! SNode)
                }
            }
        }
        
        var steps:[SGraphStep]? = [SGraphStep]()
        var previousIndex = to.nodeID
        
        while previousIndex != from.nodeID {
            if previous[previousIndex] == Int.max {
                steps = nil
                break
            }
            
            let from = nodeForID(previous[previousIndex])
            let to = nodeForID(previousIndex)
            let step = SGraphStep(from: from!, to: to!, length: distances[edgeLengthFor(from!, to: to!)])
            steps!.insert(step, at: 0)
            
            previousIndex = previous[previousIndex]
        }
        
        return steps
    }
}
