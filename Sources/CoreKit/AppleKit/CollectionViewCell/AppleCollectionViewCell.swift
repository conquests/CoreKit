//
//  AppleCollectionViewCell.swift
//  CoreKit-iOS
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
public typealias AppleCollectionViewCell = UICollectionViewCell
#elseif os(macOS)
public typealias AppleCollectionViewCell = NSCollectionViewItem
#endif
