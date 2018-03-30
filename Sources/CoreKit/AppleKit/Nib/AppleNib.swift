//
//  AppleNib.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(macOS) || os(iOS) || os(tvOS)

    #if os(macOS)
        public typealias AppleNib = NSNib
    #else
        public typealias AppleNib = UINib
    #endif

#endif
