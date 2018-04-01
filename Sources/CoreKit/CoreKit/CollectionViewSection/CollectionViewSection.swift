//
//  CollectionViewSection.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

    public typealias CollectionViewCallback = (Any, AppleIndexPath) -> Void

    open class CollectionViewSection {

        public var grid: Grid?
        public var header: CollectionViewViewModelProtocol?
        public var footer: CollectionViewViewModelProtocol?
        public var items: [CollectionViewViewModelProtocol]
        public var callback: CollectionViewCallback?

        public init(grid: Grid? = nil,
                    header: CollectionViewViewModelProtocol? = nil,
                    footer: CollectionViewViewModelProtocol? = nil,
                    items: [CollectionViewViewModelProtocol] = [],
                    callback: CollectionViewCallback? = nil) {
            self.grid = grid
            self.header = header
            self.footer = footer
            self.items = items
            self.callback = callback
        }
    }

#endif
