# UUID
[![Swift][swift-badge]][platform-url] [![Zewo][zewo-badge]][zewo-url] [![Platform][platform-badge]][platform-url] [![License][mit-badge]][mit-url] [![Slack][slack-badge]][slack-url] [![Travis][travis-badge]][travis-url] [![Codebeat][codebeat-badge]][codebeat-url]

**UUID** allows your to easily create Universally Unique Identifiers. Pure Swift.


## Installation

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/Ponyboy47/UUID.git", majorVersion: 0, minor: 8)
    ]
)
```

Compiles with swift 3.1. Compatibility with other versions of Swift is not guaranteed.

## Usage

### Generating a UUID

```swift
let uuid = UUID()
uuid.description // -> E8FAF8A3-B358-4235-A1B9-CC2C3B7ECB5F
```

### Creating a UUID

```swift
let uuid = UUID(rawValue: "E8FAF8A3-B358-4235-A1B9-CC2C3B7ECB5F")
uuid.description // -> E8FAF8A3-B358-4235-A1B9-CC2C3B7ECB5F
```

## Support

If you need any help you can join our [Slack][slack-url] and go to the **#help** channel. Or you can create a Github [issue](https://github.com/Zewo/Zewo/issues/new) in our main repository. When stating your issue be sure to add enough details, specify what module is causing the problem and reproduction steps.

## Community

[![Slack][slack-image]][slack-url]

The entire Zewo code base is licensed under MIT. By contributing to Zewo you are contributing to an open and engaged community of brilliant Swift programmers. Join us on [Slack][slack-url] to get to know us!

## License
**UUID** is released under the MIT license. See [LICENSE](LICENSE) for details.

[codebeat-badge]: https://codebeat.co/badges/e6e7bdb7-155e-4d8e-909c-eec6e3c647f4
[codebeat-url]: https://codebeat.co/projects/github-com-zewo-uuid
[mit-badge]: https://img.shields.io/badge/License-MIT-blue.svg?style=flat
[mit-url]: https://tldrlegal.com/license/mit-license
[platform-badge]: https://img.shields.io/badge/Platform-%20Linux-lightgray.svg?style=flat
[platform-url]: https://swift.org
[slack-badge]: https://zewo-slackin.herokuapp.com/badge.svg
[slack-image]: http://s13.postimg.org/ybwy92ktf/Slack.png
[slack-url]: http://slack.zewo.io
[swift-badge]: https://img.shields.io/badge/Swift-3.1-orange.svg?style=flat
[swift-url]: https://swift.org
[travis-badge]: https://travis-ci.org/Ponyboy47/UUID.svg?branch=master
[travis-url]: https://travis-ci.org/Ponyboy47/UUID
[zewo-badge]: https://img.shields.io/badge/Zewo-0.7-FF7565.svg?style=flat
[zewo-url]: http://zewo.io
