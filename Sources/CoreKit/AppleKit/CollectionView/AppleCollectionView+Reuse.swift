//
//  AppleCollectionView+Reuse.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 10. 12..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(macOS) || os(iOS) || os(tvOS)

    public extension AppleCollectionView {

        /**
         Register a collection view item for reuse
         
         Example: collectionView.register(reusableItem: MyItem.self)
         */
        public func register<T: AppleCollectionViewCell>(reusableItem: T.Type) {
            T.register(itemFor: self)
        }

        /**
         Reuse a generic collection view item
         
         Example: collectionView.dequeue(indexPath: indexPath) as MyItem
         */
        func dequeue<T: AppleCollectionViewCell>(indexPath: AppleIndexPath) -> T {
            return T.reuse(self, indexPath: indexPath) as! T
        }

        /**
         Register a collection view item for reuse with a kind
         */
        public func register<T: AppleCollectionViewCell>(reusableItem: T.Type, kind: AppleCollectionViewCell.Kind) {
            T.register(itemFor: self, kind: kind)
        }

        /**
         Reuse a generic collection view item with a kind
         */
        func dequeue<T: AppleCollectionViewCell>(indexPath: AppleIndexPath, kind: AppleCollectionViewCell.Kind) -> T {
            return T.reuse(self, indexPath: indexPath, kind: kind) as! T
        }
    }

#endif
