import XCTest
@testable import UUID

class UUIDTests: XCTestCase {

    func testCreateRandomUUID() {
        // if it doesn't crash, we're good
        let uuid = UUID()
        print(uuid)
    }

    func testPerformance() {
        measure {
            for _ in 0..<1_000 {
                let uuid = UUID()
                uuid.rawValue
            }
        }
    }

    func testUUIDString() {
        let string = "5BFEB194-68C4-48E8-8F43-3C586364CB6F"

        XCTAssertNotNil(UUID(rawValue: string))
        XCTAssertEqual(UUID(rawValue: string)?.description, string)
        XCTAssertEqual(UUID(rawValue: UUID(rawValue: string)?.rawValue ?? "")?.rawValue, string)
        XCTAssertNil(UUID(rawValue: "BadInput"))
    }

    func testEquality() {
        let uuid1 = UUID()
        let uuid2 = UUID()

        XCTAssertEqual(uuid1, uuid1)
        XCTAssertEqual(uuid2, uuid2)
        XCTAssertNotEqual(uuid1, uuid2)
    }

    func testHashing() {
        let string = "5BFEB194-68C4-48E8-8F43-3C586364CB6F"
        let uuid = UUID(rawValue: string)

        let uuid1 = UUID()
        let uuid2 = UUID()

        print(uuid1.hashValue)
        print(uuid2.hashValue)
        // make sure its consistent
        XCTAssertEqual(uuid?.hashValue, -1502156184398809678)
        XCTAssertEqual(uuid1.hashValue, uuid1.hashValue)
        XCTAssertEqual(uuid2.hashValue, uuid2.hashValue)
        // make sure its unique
        XCTAssertNotEqual(uuid1.hashValue, uuid2.hashValue)
    }
}

extension UUIDTests {
    static var allTests : [(String, (UUIDTests) -> () throws -> Void)] {
        return [
           ("testCreateRandomUUID", testCreateRandomUUID),
           ("testPerformance", testPerformance),
           ("testUUIDString", testUUIDString),
           ("testEquality", testEquality),
           ("testHashing", testHashing)
        ]
    }
}
