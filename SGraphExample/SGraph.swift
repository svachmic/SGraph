//
//  SGraph.swift
//  SGraphExample
//
//  Created by Michal Švácha on 19/10/14.
//  Copyright (c) 2014 Michal Švácha. All rights reserved.
//

import Foundation

class SGraph : NSObject {
    var root: SNode?
    var edges: Dictionary<SNode, [SEdge]> = Dictionary<SNode, [SEdge]>()
    var nodes:NSMutableSet = NSMutableSet()
    
    func addEdge(from: SNode, to: SNode) {
        root = root ?? from
        
        var newEdge = SEdge(destination: to, lng: 1, edgeId: 42)
        
        if let toArr = edges[from] {
            var toArr2 = toArr
            toArr2.append(newEdge)
            edges[from] = toArr2
        } else {
            var toArrNew = [SEdge]()
            toArrNew.append(newEdge)
            edges[from] = toArrNew
        }
    }
    
    func addBidirectionalEdge(#from: SNode, to: SNode) {
        addEdge(from, to: to)
        addEdge(to, to: from)

        self.addNode(from)
        self.addNode(to)
    }
    
    func addNode(node:SNode) {
        nodes.addObject(node)
        
        if edges[node] == nil {
            var toArrNew = [SEdge]()
            edges[node] = toArrNew
        }
    }
    
    func nodeForID(nodeID:Int)->SNode? {
        for key in edges.keys {
            if key.nodeID == nodeID {
                return key
            }
        }
        return nil
    }
    
    func edgeLengthFor(from:SNode, to:SNode) -> Int {
        var array = edges[from]
        
        for neighbor in array! {
            let edge = neighbor as SEdge
            
            if edge.destinationNode.nodeID == to.nodeID {
                return edge.length
            }
        }
        
        return NSIntegerMax
    }
    
    func minimumSpanningTree() -> SGraph? {
        return nil
    }
    
    func eulerianPath() -> SGraph? {
        return nil
    }
    
    func shortestPath(#from:SNode, to:SNode) -> [SGraphStep]? {
        var keys:NSMutableSet = NSMutableSet(set: self.nodes)
        var distances = [Int](count: keys.count, repeatedValue: NSIntegerMax)
        var previous = [Int](count: keys.count, repeatedValue: NSIntegerMax)
        distances[from.nodeID] = 0
        
        var u = from
        
        while keys.count > 0 {
            var array = edges[u]
            
            for neighbor in array! {
                let edge = neighbor
                var distance = distances[u.nodeID] + edge.length
                if distance < distances[edge.destinationNode.nodeID] {
                    distances[edge.destinationNode.nodeID] = distance
                    previous[edge.destinationNode.nodeID] = u.nodeID
                }
            }
            
            keys.removeObject(u)
            
            if keys.count > 0 {
                var smallestCandidate: SNode = keys.allObjects[0] as SNode
                for key in keys {
                    let vertex = key as SNode
                    
                    if distances[vertex.nodeID] < distances[smallestCandidate.nodeID] {
                        smallestCandidate = vertex
                    }
                }
                u = smallestCandidate
            }
        }
        
        var steps:[SGraphStep]? = [SGraphStep]()
        
        var previousIdx = to.nodeID
        
        while previousIdx != from.nodeID {
            if previous[previousIdx] == NSIntegerMax {
                steps = nil
                break
            }
            
            var step:SGraphStep = SGraphStep()
            
            step.from = nodeForID(previous[previousIdx])
            step.to = nodeForID(previousIdx)
            
            step.length = distances[edgeLengthFor(step.from!, to: step.to!)]
            steps!.insert(step, atIndex: 0)
            
            previousIdx = previous[previousIdx]
        }
        
        return steps
    }
}
