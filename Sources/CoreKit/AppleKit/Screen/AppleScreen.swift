//
//  AppleScreen.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)

    public typealias AppleScreen = UIScreen

    public extension AppleScreen {

        public static var `default`: AppleScreen {
            return AppleScreen.main
        }
    }

#endif

#if os(macOS)

    public typealias AppleScreen = NSScreen

    public extension AppleScreen {

        public var bounds: CGRect { return NSRectToCGRect(self.visibleFrame) }

        public static var `default`: AppleScreen {
            return AppleScreen.main! // swiftlint:disable:this force_unwrapping
        }
    }

#endif

#if os(watchOS)

    // TODO: this one is really bad... but for now i'm fine with it.
    public typealias AppleScreen = WKInterfaceDevice

    public extension AppleScreen {
        public static var `default`: AppleScreen {
            return WKInterfaceDevice.current()
        }
    }

#endif
