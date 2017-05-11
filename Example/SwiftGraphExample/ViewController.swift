//
//  ViewController.swift
//  SwiftGraphExample
//
//  Created by Michal Švácha on 10.04.15.
//  Copyright © 2017 Michal Svacha. All rights reserved.
//

import UIKit
import SwiftGraph

class ViewController: UIViewController {
    var graph: Graph!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testShortestPath()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func testShortestPath() {
        self.graph = Graph()
        
        let node1 = Node(nodeID: 0)
        let node2 = Node(nodeID: 1)
        let node3 = Node(nodeID: 2)
        let node4 = Node(nodeID: 3)
        let node5 = Node(nodeID: 4)
        let node6 = Node(nodeID: 5)
        
        // lonely node
        let node7 = Node(nodeID: 6)
        self.graph.add(node: node7)
        
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
    
    func findPath(_ from: Node, to: Node) {
        if let trail = self.graph.shortestPath(from: from, to: to) {
            _ = trail.map({ print("\($0.description)") })
            print()
        } else {
            print("No route leading out")
        }
    }
}

