//
//  MyCellView.swift
//  NSOutlineViewSimpleDemo
//
//  Created by HIROKI IKEUCHI on 2021/02/20.
//

import Cocoa

class MyCellView: NSTableCellView, NibInstantiatable {

    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: NSTextField!

    // MARK: - Lifecycle
    
    // MARK: - Drawing Method

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

    // MARK: - Actions
    
    // MARK: - Helpers

    func configureUI(withNode node: Node) {
        titleLabel.stringValue = node.title
    }
}

