//
//  UUID.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 6/29/15.
//  Copyright © 2015 PureSwift. All rights reserved.
//

import OperatingSystem
#if os(Linux)
    import CUUID
#endif

/// A representation of a universally unique identifier (```UUID```).
public struct UUID: RawRepresentable, CustomStringConvertible {

    /// Raw byte type for UUID
    public typealias ByteValue = (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

    // MARK: - Public Properties

    public var byteValue: ByteValue

    // MARK: - Initialization

    public init() {
        self.byteValue = POSIXUUIDCreateRandom()
    }

    public init(byteValue: ByteValue) {
        self.byteValue = byteValue
    }

    public var description: String {
        return "\(self.rawValue)"
    }
}

// MARK: - RawRepresentable

public extension UUID {

    init?(rawValue: String) {

        guard let uuid = POSIXUUIDConvertStringToUUID(rawValue)
            else { return nil }

        self.byteValue = uuid
    }

    var rawValue: String {

        return POSIXUUIDConvertToString(byteValue)
    }
}

// MARK: - POSIX UUID System Type Functions
public typealias POSIXUUIDStringType = (Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8)

public func POSIXUUIDCreateRandom() -> uuid_t {

    var uuid = uuid_t(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)

    withUnsafeMutablePointer(&uuid, { (valuePointer: UnsafeMutablePointer<uuid_t>) -> Void in

        let bufferType = UnsafeMutablePointer<UInt8>.self

        let buffer = unsafeBitCast(valuePointer, to: bufferType)

        uuid_generate(buffer)
    })

    return uuid
}

public func POSIXUUIDConvertToString(uuid: uuid_t) -> String {

    let uuidString = POSIXUUIDConvertToUUIDString(uuid)

    return POSIXUUIDStringConvertToString(uuidString)
}

public func POSIXUUIDConvertToUUIDString(uuid: uuid_t) -> POSIXUUIDStringType {

    var uuidCopy = uuid

    var uuidString = POSIXUUIDStringType(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

    withUnsafeMutablePointers(&uuidCopy, &uuidString) { (uuidPointer: UnsafeMutablePointer<uuid_t>, uuidStringPointer: UnsafeMutablePointer<POSIXUUIDStringType>) -> Void in

        let stringBuffer = unsafeBitCast(uuidStringPointer, to: UnsafeMutablePointer<Int8>.self)

        let uuidBuffer = unsafeBitCast(uuidPointer, to: UnsafeMutablePointer<UInt8>.self)

        uuid_unparse(unsafeBitCast(uuidBuffer, to: UnsafePointer<UInt8>.self), stringBuffer)
    }

    return uuidString
}

public func POSIXUUIDStringConvertToString(uuidString: POSIXUUIDStringType) -> String {

    var uuidStringCopy = uuidString

    return withUnsafeMutablePointer(&uuidStringCopy, { (valuePointer: UnsafeMutablePointer<POSIXUUIDStringType>) -> String in

        let bufferType = UnsafeMutablePointer<CChar>.self

        let buffer = unsafeBitCast(valuePointer, to: bufferType)

        return String(validatingUTF8: unsafeBitCast(buffer, to: UnsafePointer<CChar>.self))!
    })
}

public func POSIXUUIDConvertStringToUUID(string: String) -> uuid_t? {

    let uuidPointer = UnsafeMutablePointer<uuid_t>(allocatingCapacity: 1)
    defer { uuidPointer.deallocateCapacity(1) }

    guard uuid_parse(string, unsafeBitCast(uuidPointer, to: UnsafeMutablePointer<UInt8>.self)) != -1 else {

        return nil
    }

    return uuidPointer.pointee
}
