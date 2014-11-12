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
    var edges: Dictionary<SNode, NSMutableArray> = Dictionary<SNode, NSMutableArray>()
    var nodes:NSMutableSet = NSMutableSet()
    
    func addEdge(from: SNode, to: SNode) {
        root = root == nil ? from : root
        
        var newEdge = SEdge(destination: to, lng: 1, edgeId: 42)
        
        if let toArr:NSMutableArray = edges[from] {
            toArr.addObject(newEdge)
        } else {
            var toArrNew = NSMutableArray()
            toArrNew.addObject(newEdge)
            edges[from] = toArrNew
        }
    }
    
    func addBidirectionalEdge(from: SNode, to: SNode) {
        addEdge(from, to: to)
        addEdge(to, to: from)

        self.addNode(from)
        self.addNode(to)
    }
    
    func addNode(node:SNode) {
        nodes.addObject(node)
        
        if edges[node] == nil {
            var toArrNew = NSMutableArray()
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
    
    func dfs(start: SNode) {
        start.isTraversed = true;
        
        if let children = edges[start] {
            for child in children {
                dfs(child as SNode)
            }
        } else {
            NSLog("No more children");
        }
        
        start.isTraversed = false
    }
    
    func minimumSpanningTree() -> SGraph? {
        return nil
    }
    
    func eulerianPath() -> SGraph? {
        return nil
    }
    
    func shortestPath(from:SNode, to:SNode) -> Array<SGraphStep>? {
        var keys:NSMutableSet = NSMutableSet(set: self.nodes)
        var distances = [Int](count: keys.count, repeatedValue: NSIntegerMax)
        var previous = [Int](count: keys.count, repeatedValue: NSIntegerMax)
        distances[from.nodeID] = 0
        
        var u = from
        
        while keys.count > 0 {
            var array = edges[u]
            
            for neighbor in array! {
                let edge = neighbor as SEdge
                var distance = distances[u.nodeID] + edge.length
                if distance < distances[edge.destinationNode.nodeID] {
                    distances[edge.destinationNode.nodeID] = distance
                    previous[edge.destinationNode.nodeID] = u.nodeID
                }
            }
            keys.removeObject(u)
            
            if keys.count > 0 {
                var smallestCandidate:SNode = keys.allObjects[0] as SNode
                for key in keys {
                    let vertex = key as SNode
                    
                    if distances[vertex.nodeID] < distances[smallestCandidate.nodeID] {
                        smallestCandidate = vertex
                    }
                }
                u = smallestCandidate
            }
        }
        
        var steps:[SGraphStep]? = Array<SGraphStep>()
        
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
