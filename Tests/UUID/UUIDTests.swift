//
//  UUIDTests.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 7/2/15.
//  Copyright © 2015 PureSwift. All rights reserved.
//

import XCTest
@testable import UUID

class UUIDTests: XCTestCase {

    func testCreateRandomUUID() {

        // try to create without crashing
        let uuid = UUID()
        print(uuid)

        // pass
        XCTAssert(true)
    }

    func testUUIDString() {

        let stringValue = "5BFEB194-68C4-48E8-8F43-3C586364CB6F"

        guard let uuid = UUID(rawValue: stringValue)
            else { XCTFail("Could not create UUID from " + stringValue); return }

        XCTAssert(uuid.rawValue == stringValue, "UUID is \(uuid), should be \(stringValue)")
    }

    func testCreateFromString() {

        let stringValue = "5BFEB194-68C4-48E8-8F43-3C586364CB6F"

        XCTAssert((UUID(rawValue: stringValue) != nil), "Could not create UUID with string \"\(stringValue)\"")

        XCTAssert((UUID(rawValue: "BadInput") == nil), "UUID should not be created")
    }
}

extension UUIDTests {
    static var allTests : [(String, UUIDTests -> () throws -> Void)] {
        return [
           ("testCreateRandomUUID", testCreateRandomUUID),
           ("testUUIDString", testUUIDString),
           ("testCreateFromString", testCreateFromString)
        ]
    }
}
