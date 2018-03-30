//
//  AppleFont+Height.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)

    public extension AppleFont {

        public func height(ofString string: String, constrainedToWidth width: CGFloat) -> CGFloat {
            let attr = [NSAttributedStringKey.font: self]
            let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
            let rect = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attr, context: nil)
            return rect.size.height
        }
    }

#endif
