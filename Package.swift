import PackageDescription

let package = Package(
    name: "UUID",
    dependencies: [
        .Package(url: "https://github.com/Zewo/OS.git", majorVersion: 0, minor: 4)
    ]
)

#if os(Linux)
package.dependencies.append(Package.Dependency.Package(url: "https://github.com/PureSwift/CUUID.git", majorVersion: 1))
#endif
