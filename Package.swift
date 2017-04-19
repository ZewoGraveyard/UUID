import PackageDescription

let package = Package(
    name: "UUID",
    dependencies: [
        .Package(url: "https://github.com/Zewo/POSIX.git", majorVersion: 0, minor: 15)
    ]
)
