# UUID
[![Swift 3](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://swift.org) [![Platform Linux](https://img.shields.io/badge/Platform-Linux-lightgray.svg?style=flat)](https://swift.org) [![License MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](https://tldrlegal.com/license/mit-license)

Easily generate UUID's (Universally Unique Identifier). Development snapshots 04/12-05/03 are supported in 0.2. For earlier versions use 0.1.

This is ripped out of [SwiftFoundation](https://github.com/PureSwift/SwiftFoundation) with some minor changes.

## Usage

```swift
let uuid = UUID()
print(uuid.description) // -> E8FAF8A3-B358-4235-A1B9-CC2C3B7ECB5F
```

## Installation
Simply add `UUID` to your `Package.swift`

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/Danappelxx/UUID.git", majorVersion: 0, minor: 1),
    ]
)
```

Linux? One more step:

```shell
sudo apt-get install uuid-dev
```

## Reach out
Have any questions? I'm active on the [SwiftX](http://swiftx-slackin.herokuapp.com) and [Zewo](http://slack.zewo.io) slacks.

## License
**UUID** is released under the MIT license. See LICENSE for details.
