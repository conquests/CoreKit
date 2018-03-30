//
//  Object+UniqueIdentifierTests.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit

class ObjectUniqueIdentifierTests: XCTestCase {

    func test() {
        XCTAssert("NSObject" == NSObject.uniqueIdentifier)
        XCTAssert("NSDate" == NSDate.uniqueIdentifier)
        XCTAssert("NSString" == NSString.uniqueIdentifier)
    }
}
