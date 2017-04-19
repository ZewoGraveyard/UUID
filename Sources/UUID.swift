//
//  UUID.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 6/29/15.
//  Copyright © 2015 PureSwift. All rights reserved.
//

import POSIX
#if os(Linux)
import Glibc
#else
import Darwin
#endif

public struct UUID {

    static let size = 16

    private final class DeallocatingContainer {
        let bytes: UnsafeMutablePointer<UInt8>
        init(bytes: UnsafeMutablePointer<UInt8>) {
            self.bytes = bytes
        }

        deinit {
            bytes.deallocate(capacity: UUID.size)
        }
    }

    private let container: DeallocatingContainer
    public var bytes: UnsafeMutablePointer<UInt8> {
        return container.bytes
    }

    /**
     Creates a UUID directly from the bytes given.

     - note: Performs no safety checks or copies. However, it does
     deallocate the memory when it is no longer in use.
     */
    public init(bytes: UnsafeMutablePointer<UInt8>) {
        self.container = DeallocatingContainer(bytes: bytes)
    }

    /**
     Reads 16 bytes from /dev/urandom to create a UUID.
     */
    public init() {
        let bytes: UnsafeMutablePointer<UInt8> = {
            let bytes = UnsafeMutablePointer<UInt8>.allocate(capacity: UUID.size)
            let fd = open("/dev/urandom", O_RDONLY)
            read(fd, bytes, UUID.size)
            close(fd)
            return bytes
        }()

        bytes[6] = (bytes[6] & 0x0F) | 0x40
        bytes[8] = (bytes[8] & 0x3f) | 0x80

        self.init(bytes: bytes)
    }
}

extension UUID: CustomStringConvertible, RawRepresentable {
    /// Returns the UUID in the following format
    ///   `XXXX-XX-XX-XX-XXXXXX`
    /// where each X represents the hexadecimal
    /// representation of each byte.
    public var description: String {
        return rawValue
    }

    /// Returns the UUID in the following format
    /// `XXXX-XX-XX-XX-XXXXXX`
    /// where each X represents the hexadecimal
    /// representation of each byte.
    public var rawValue: String {
        let ranges = [0..<4, 4..<6, 6..<8, 8..<10, 10..<16]

        return ranges.map { range in
            var str = ""
            for i in range {
                str += String(bytes[i], radix: 16, uppercase: true)
            }
            return str
        }.joined(separator: "-")
    }

    /**
     Attempts to create a UUID by parsing the string.
     A correct UUID has the following format:
       `XXXX-XX-XX-XX-XXXXXX`
     where each X represents the hexadecimal
     representation of each byte.
     */
    public init?(rawValue: String) {
        guard rawValue.characters.count == 36 else {
            return nil
        }

        let bytes = UnsafeMutablePointer<UInt8>.allocate(capacity: UUID.size)

        let out = UnsafeMutablePointer<Int32>.allocate(capacity: 1)
        defer { out.deallocate(capacity: 1) }

        let result: Int32 = rawValue.withCString { cString in
            let list = (0..<UUID.size).map { bytes.advanced(by: $0) as CVarArg }
            return withVaList(list + [out]) { args in
                vsscanf(
                    // in
                    cString,
                    // format
                    "%2hhx%2hhx%2hhx%2hhx-%2hhx%2hhx-%2hhx%2hhx-%2hhx%2hhx-%2hhx%2hhx%2hhx%2hhx%2hhx%2hhx%n",
                    // args
                    args
                )
            }
        }

        guard result == 16 && out.pointee == 36 else {
            return nil
        }

        self.init(bytes: bytes)
    }
}

extension UUID: Hashable {
    public var hashValue: Int {
        // Thanks to Ethan Jackwitz!
        // https://gist.github.com/vdka/3710efec131a403ae793a749edf34484#file-bytehashable-swift-L14-L31

        var h = 0
        for i in 0..<UUID.size {
            h = h &+ numericCast(bytes[i])
            h = h &+ (h << 10)
            h ^= (h >> 6)
        }

        h = h &+ (h << 3)
        h ^= (h >> 11)
        h = h &+ (h << 15)

        return h
    }
}

extension UUID: Equatable { }

public func == (lhs: UUID, rhs: UUID) -> Bool {
    return memcmp(lhs.bytes, rhs.bytes, UUID.size) == 0
}
