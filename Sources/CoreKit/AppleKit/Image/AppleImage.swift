//
//  AppleImage.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(macOS)
public typealias AppleImage = NSImage

public extension AppleImage {
    public var cgImage: CGImage {
        let imageData = self.tiffRepresentation
        // swiftlint:disable:next force_unwrapping
        let source = CGImageSourceCreateWithData(imageData! as CFData, nil)!
        let maskRef = CGImageSourceCreateImageAtIndex(source, 0, nil)
        // swiftlint:disable:next force_unwrapping
        return maskRef!
    }
}
#else
public typealias AppleImage = UIImage
#endif
