// swift-tools-version:4.0

import PackageDescription

// Until 'real' appleOS targets are not supported (WWDC18?!?),
// this is going to speed up builds on pure Linux & Darwin
// basically this will only turn on Swift, Foundation, Dispatch
let excludePaths = [
                        "AppleKit",
                        "ARKit",
                        "CoreGraphics",
                        "CoreKit",
                        "CoreLocation",
                        "QuartzCore",
                        "SpriteKit",
                        "StoreKit",
                        "WatchKit",
                    ]

let package = Package(
    name: "CoreKit",
    products: [
        .library(
            name: "CoreKit",
            targets: ["CoreKit"]
        )
    ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "CoreKit",
            dependencies: [],
            path: "./Sources/CoreKit",
            exclude: excludePaths
            //sources: ["main.swift"]
        ),
        .testTarget(
            name: "CoreKitTests",
            dependencies: ["CoreKit"],
            path: "./Tests/Sources",
            exclude: excludePaths
        )
    ]
)
