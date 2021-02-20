//
//  ViewController.swift
//  NSOutlineViewSimpleDemo
//
//  Created by HIROKI IKEUCHI on 2021/02/17.
//

import Cocoa


final class ViewController: NSViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var outlineView: NSOutlineView!
    private var nodes = [Node]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeOutlineView()
        outlineView.expandItem(nil, expandChildren: true)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
    
    // MARK: - Actions
    
    // ダブルクリックで開閉させたい場合
    @IBAction func doubleClickedItem(_ sender: NSOutlineView) {
        
        guard let node = sender.item(atRow: sender.clickedRow) as? Node,
              node.hasChildren else {
            return
        }
        
        if sender.isItemExpanded(node) {
            sender.animator().collapseItem(node)
        } else {
            sender.animator().expandItem(node)
        }
    }
    
    // MARK: - Helpers
    
    private func initializeOutlineView() {
        // 別のXibファイルから読み込む場合は登録が必要
        outlineView.register(MyCellView.nib(inBundle: nil),
                             forIdentifier: NSUserInterfaceItemIdentifier(rawValue: String(describing: MyCellView.self)))
        outlineView.delegate = self
        outlineView.dataSource = self
        outlineView.autosaveExpandedItems = true
        
        // スタイルの設定
        outlineView.selectionHighlightStyle = .regular
        outlineView.floatsGroupRows = false
        
        nodes.append(contentsOf: Node.createSampleNodes())
        outlineView.reloadData()
    }
    
}

// MARK: - NSOutlineViewDataSource

extension ViewController: NSOutlineViewDataSource {
    // itemが含むchildrenの数を返す
    // item = nilの場合、トップレベルの項目のChildrenの数を返す
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if let node = item as? Node {
            return node.numberOfChildren
        }
        
        return nodes.count
    }
    
    // 親に対する子の情報を与える
    // item will be nil for the root object.
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let feed = item as? Node {
            return feed.children[index]
        }
        
        return nodes[index]
    }
    
    // trueを返すとき、CellViewににDisclosure Buttonが表示される
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let node = item as? Node {
            return node.hasChildren
        }
        
        return false
    }
    
    // グループ行かどうか（NSOutlineViewの設定如何では見た目と挙動が特別となる）
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        guard let node = item as? Node else {
            return false
        }
        
        return node.nodeType == .group
    }
    
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        return 20
    }
}

// MARK: - NSOutlineViewDelegate

extension ViewController: NSOutlineViewDelegate {
    
    // 各CellViewの設定
    public func outlineView(_ outlineView: NSOutlineView,
                            viewFor tableColumn: NSTableColumn?,
                            item: Any) -> NSView? {
        
        guard
            let myCellView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: String(describing: MyCellView.self)), owner: self) as? MyCellView,
            let node = item as? Node
        else {
            return nil
        }
        
        myCellView.configureUI(withNode: node)
        
        return myCellView
    }
    
    // 行選択の可否
    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        return true
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let outlineView = notification.object as? NSOutlineView else {
            return
        }
        
        let selectedIndex = outlineView.selectedRow
        guard let node = outlineView.item(atRow: selectedIndex) as? Node else {
            return
        }
        
        print("Selected Title: \(node.title)")
    }
}
