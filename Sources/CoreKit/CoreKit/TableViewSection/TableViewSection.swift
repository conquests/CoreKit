//
//  TableViewSection.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 01. 28..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

#if os(iOS)

    class TableViewSection {
        var items: [TableViewDataProtocol] = []
        var header: TableViewDataProtocol?
        var footer: TableViewDataProtocol?
    }

#endif
