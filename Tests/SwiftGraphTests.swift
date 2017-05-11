//
//  SwiftGraphTests.swift
//  SwiftGraphTests
//
//  Created by Michal Svacha on 11.05.17.
//  Copyright © 2017 Michal Svacha. All rights reserved.
//

import XCTest

class SwiftGraphTests: XCTestCase {
    var graph: Graph!
    
    override func setUp() {
        super.setUp()
        
        graph = Graph()
        
        let node1 = Node(nodeID: 0)
        let node2 = Node(nodeID: 1)
        let node3 = Node(nodeID: 2)
        let node4 = Node(nodeID: 3)
        let node5 = Node(nodeID: 4)
        let node6 = Node(nodeID: 5)
        
        graph.addBidirectionalEdge(from: node1, to: node2)
        graph.addBidirectionalEdge(from: node1, to: node3)
        graph.addBidirectionalEdge(from: node2, to: node4)
        graph.addBidirectionalEdge(from: node4, to: node5)
        graph.addBidirectionalEdge(from: node3, to: node6)
        
        // lonely node
        let node7 = Node(nodeID: 6)
        graph.add(node: node7)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNodePresence() {
        XCTAssertNotNil(graph.node(with: 0))
        XCTAssertNotNil(graph.node(with: 1))
        XCTAssertNotNil(graph.node(with: 2))
        XCTAssertNotNil(graph.node(with: 3))
        XCTAssertNotNil(graph.node(with: 4))
        XCTAssertNotNil(graph.node(with: 5))
        XCTAssertNotNil(graph.node(with: 6))
    }
    
    func testForwardPath() {
        let node1 = graph.node(with: 0)!
        let node6 = graph.node(with: 5)!
        
        XCTAssertNotNil(graph.shortestPath(from: node1, to: node6))
    }
    
    func testBackwardPath() {
        let node1 = graph.node(with: 0)!
        let node4 = graph.node(with: 3)!
        
        XCTAssertNotNil(graph.shortestPath(from: node4, to: node1))
    }
    
    func testNoPath() {
        let node1 = graph.node(with: 0)!
        let node7 = graph.node(with: 6)!
        
        XCTAssertNil(graph.shortestPath(from: node1, to: node7))
    }
}
