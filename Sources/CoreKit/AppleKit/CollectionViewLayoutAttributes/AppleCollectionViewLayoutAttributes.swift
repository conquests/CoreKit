//
//  AppleCollectionViewLayoutAttributes.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
public typealias AppleCollectionViewLayoutAttributes = UICollectionViewLayoutAttributes
#endif
#if os(macOS)
public typealias AppleCollectionViewLayoutAttributes = NSCollectionViewLayoutAttributes
#endif
