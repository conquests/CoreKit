//
//  Enum+CollectionTests.swift
//  CoreKit-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit

class EnumCollectionTests: XCTestCase {

    enum IntEnum: Int, EnumCollection {
        case a
        case b
        case c
    }

    enum StringEnum: String, EnumCollection {
        case a = "test"
        case b
    }

    func test_allValues() {
        XCTAssert(IntEnum.allValues.count == 3)
        XCTAssert(StringEnum.allValues.count == 2)
        XCTAssert(IntEnum.allValues.map { $0.rawValue } == [0, 1, 2])
        XCTAssert(StringEnum.allValues.map { $0.rawValue } == ["test", "b"])
    }

    func test_count() {
        XCTAssert(IntEnum.count == 3)
        XCTAssert(StringEnum.count == 2)
    }
}
