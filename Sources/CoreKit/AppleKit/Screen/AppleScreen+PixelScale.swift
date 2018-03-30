//
//  AppleScreen+PixelScale.swift
//  CoreKit-iOS
//
//  Created by Tibor Bödecs on 2018. 03. 30..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

public extension AppleScreen {
    
    /**
     Returns the size of a real pixel based on the default screen's scale factor.
     
     - returns: The real pixel size in CGFloat
     */
    public static var pixelScale: CGFloat {
        #if os(watchOS)
        return 1.0 / AppleScreen.default.screenScale
        #elseif os(iOS) || os(tvOS)
        return 1.0 / AppleScreen.default.scale
        #elseif os(macOS)
        return 1.0 / AppleScreen.default.backingScaleFactor
        #else
        return 1.0
        #endif
    }
}

#endif
