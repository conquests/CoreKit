//
//  CoreKit.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 03. 30..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

@_exported import Foundation

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

    #if os(macOS)
    @_exported import AppKit
    #elseif os(iOS) || os(tvOS)
    @_exported import UIKit
    #elseif  os(watchOS)
    @_exported import WatchKit
    #endif

#endif
