import XCTest
@testable import UUID

class UUIDTests: XCTestCase {

    func testCreateRandomUUID() {
        let _ = UUID()
        XCTAssert(true)
    }

    func testUUIDString() {
        let stringValue = "5BFEB194-68C4-48E8-8F43-3C586364CB6F"

        guard let uuid = UUID(rawValue: stringValue) else {
            return XCTFail("Could not create UUID from " + stringValue)
        }

        XCTAssert(uuid.rawValue == stringValue, "UUID is \(uuid), should be \(stringValue)")
    }

    func testCreateFromString() {
        let stringValue = "5BFEB194-68C4-48E8-8F43-3C586364CB6F"

        XCTAssert((UUID(rawValue: stringValue) != nil), "Could not create UUID with string \"\(stringValue)\"")
        XCTAssert((UUID(rawValue: "BadInput") == nil), "UUID should not be created")
    }
}

extension UUIDTests {
    static var allTests : [(String, (UUIDTests) -> () throws -> Void)] {
        return [
           ("testCreateRandomUUID", testCreateRandomUUID),
           ("testUUIDString", testUUIDString),
           ("testCreateFromString", testCreateFromString)
        ]
    }
}
