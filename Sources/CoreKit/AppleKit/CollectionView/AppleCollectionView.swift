//
//  AppleCollectionView.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
public typealias AppleCollectionView = UICollectionView
public typealias AppleCollectionViewSource = UICollectionViewDataSource
public typealias AppleCollectionViewDelegate = UICollectionViewDelegate
#endif
#if os(macOS)
public typealias AppleCollectionView = NSCollectionView
public typealias AppleCollectionViewSource = NSCollectionViewDataSource
public typealias AppleCollectionViewDelegate = NSCollectionViewDelegate
#endif
