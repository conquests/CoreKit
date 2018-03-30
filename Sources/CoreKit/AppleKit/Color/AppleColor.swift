//
//  AppleColor.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(macOS)
public typealias AppleColor = NSColor
#else
public typealias AppleColor = UIColor
#endif
