//
//  WKTableViewModel.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 01. 28..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

#if os(watchOS)

    public protocol WKTableViewModelProtocol {
        var type: String { get }
        func configure(item: Any)
        func callback(index: Int)
    }

    open class WKTableViewModel<Cell, Model>: WKTableViewModelProtocol where Cell: WKTableCell, Model: Any {

        public var model: Model
        public var cell: Cell.Type { return Cell.self }
        public var type: String { return Cell.objectName }

        public var callbackBlock: ((Int, Model) -> Void)?

        public init(_ model: Model, callback: ((Int, Model) -> Void)? = nil) {
            self.model = model
            self.callbackBlock = callback
        }

        // MARK: - WKCellModelProtocol

        public func configure(item: Any) {
            guard let cell = item as? Cell else {
                return
            }
            self.configure(cell: cell, model: self.model)
        }

        public func callback(index: Int) {
            self.callback(index: index, model: self.model)
        }

        // MARK: - API

        open func configure(cell: Cell, model: Model) {

        }

        open func callback(index: Int, model: Model) {
            self.callbackBlock?(index, model)
        }
    }

#endif
