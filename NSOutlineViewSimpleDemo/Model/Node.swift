//
//  Node.swift
//  NSOutlineViewSimpleDemo
//
//  Created by HIROKI IKEUCHI on 2021/02/17.
//

import Cocoa

enum NodeType {
    case group
    case parent
    case item
}

class Node {
    
    // MARK: - Properties
    
    var title: String
    var nodeType: NodeType
    var children: [Node]
    
    // MARK: - Lifecycle
    
    init(title: String,
         children: [Node] = [],
         nodeType: NodeType = .item) {
        self.title = title
        self.children = children
        self.nodeType = nodeType
    }
    
    // MARK: - Helpers
    
    var numberOfChildren: Int {
        children.count
    }
    
    var hasChildren: Bool {
        !children.isEmpty
    }
}

extension Node {
    static func createSampleNodes() -> [Node] {
        
        return [
            .init(title: "Header1", children: [
                .init(title: "Section1", children: [
                    .init(title: "Item1", children: [], nodeType: .item),
                    .init(title: "Item2", children: [], nodeType: .item),
                ], nodeType: .parent),
                .init(title: "Section2", children: [
                    .init(title: "Item3", children: [], nodeType: .item),
                    .init(title: "Item4", children: [], nodeType: .item),
                ], nodeType: .parent),
            ], nodeType: .group),
            .init(title: "Header2", children: [
                .init(title: "Section4", children: [
                    .init(title: "Item5", children: [], nodeType: .item),
                ], nodeType: .parent),
                .init(title: "Section5", children: [
                    .init(title: "Item5", children: [], nodeType: .item),
                ], nodeType: .parent),
            ],  nodeType: .group),
        ]
    }
}
