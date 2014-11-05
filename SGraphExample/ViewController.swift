//
//  ViewController.swift
//  SGraphExample
//
//  Created by Michal Švácha on 19/10/14.
//  Copyright (c) 2014 Michal Švácha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var graph:SGraph?

    override func viewDidLoad() {
        super.viewDidLoad()
        testShortestPath()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func testShortestPath() {
        self.graph = SGraph()
        
        var node1 = SNode(nodeId: 0)
        var node2 = SNode(nodeId: 1)
        var node3 = SNode(nodeId: 2)
        var node4 = SNode(nodeId: 3)
        var node5 = SNode(nodeId: 4)
        var node6 = SNode(nodeId: 5)
        
        // lonely node
        var node7 = SNode(nodeId: 6)
        self.graph!.addNode(node7)
        
        self.graph!.addBidirectionalEdge(node1, to: node2)
        self.graph!.addBidirectionalEdge(node1, to: node3)
        
        self.graph!.addBidirectionalEdge(node2, to: node4)
        self.graph!.addBidirectionalEdge(node4, to: node5)
        
        self.graph!.addBidirectionalEdge(node3, to: node6)
        
        self.findPath(node1, to: node6)
        self.findPath(node4, to: node1)
        self.findPath(node1, to: node7)
    }
    
    func findPath(from:SNode, to:SNode) {
        if let trail = self.graph!.shortestPath(from, to:to) {
            NSLog(trail.description)
        } else {
            NSLog("No route leading out")
        }
    }
}

