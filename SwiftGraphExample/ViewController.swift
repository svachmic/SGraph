//
//  ViewController.swift
//  SwiftGraphExample
//
//  Created by Michal Švácha on 10/04/15.
//  Copyright (c) 2015 Michal Švácha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var graph:SGraph!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testShortestPath()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func testShortestPath() {
        self.graph = SGraph()
        
        let node1 = SNode(nodeId: 0)
        let node2 = SNode(nodeId: 1)
        let node3 = SNode(nodeId: 2)
        let node4 = SNode(nodeId: 3)
        let node5 = SNode(nodeId: 4)
        let node6 = SNode(nodeId: 5)
        
        // lonely node
        let node7 = SNode(nodeId: 6)
        self.graph.addNode(node7)
        
        self.graph.addBidirectionalEdge(from: node1, to: node2)
        self.graph.addBidirectionalEdge(from: node1, to: node3)
        self.graph.addBidirectionalEdge(from: node2, to: node4)
        self.graph.addBidirectionalEdge(from: node4, to: node5)
        self.graph.addBidirectionalEdge(from: node3, to: node6)
        
        
        
        // 1. test
        self.findPath(node1, to: node6)
        // 2. test
        self.findPath(node4, to: node1)
        // 3. test
        self.findPath(node1, to: node7)
    }
    
    func findPath(_ from:SNode, to:SNode) {
        if let trail = self.graph.shortestPath(from: from, to: to) {
            _ = trail.map({ print("\($0.description)") })
            print()
        } else {
            print("No route leading out")
        }
    }
}

