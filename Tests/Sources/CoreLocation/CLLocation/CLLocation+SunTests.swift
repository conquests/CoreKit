//
//  CLLocation+SunTests.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 01. 16..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

import XCTest
import CoreLocation
@testable import CoreKit

class CLLocationSunTests: XCTestCase {

    func test() {

        let date = Date()
        let zone = TimeZoneLocation.local
        let location = CLLocation(latitude: zone.latitude, longitude: zone.longitude)

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Europe/Budapest")
        formatter.dateStyle = .long
        formatter.timeStyle = .long

        for (key, value) in location.sunTimes(for: date) {
            print(key + ": " + formatter.string(from: value))
        }

        XCTAssert(true)
    }
}
