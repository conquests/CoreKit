//
//  ViewController.swift
//  Example-tvOS
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: CollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let grid = Grid()
        let source = CollectionViewSource(grid: grid)
        let section = CollectionViewSection()

        section.header = StringViewModel("header")
        section.footer = StringViewModel("footer")

        for i in stride(from: 0, to: 100, by: 1) {
            let data = StringViewModel("item \(i)")

            section.items.append(data)
        }

        source.sections.append(section)
        self.collectionView.source = source
        self.collectionView.reloadData()
    }
}
