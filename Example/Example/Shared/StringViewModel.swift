//
//  StringData.swift
//  Example
//
//  Created by Tibor Bödecs on 2017. 10. 02..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreKit

class StringViewModel: CollectionViewViewModel<StringCell, String> {

    override func config(cell: StringCell, data: String, indexPath: AppleIndexPath, grid: Grid) {
        #if os(iOS) || os(tvOS)
            cell.textLabel.text = data
        #endif
        #if os(macOS)
            cell.textLabel.stringValue = data
        #endif
    }

    override func size(data: String, indexPath: AppleIndexPath, grid: Grid, view: AppleView) -> CGSize {
        return grid.size(for: view, height: 128)
    }

    override func callback(data: String, indexPath: AppleIndexPath) {
        print(data)
    }

}
