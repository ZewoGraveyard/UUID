import PackageDescription

let package = Package(
    name: "UUID"
)

#if os(Linux)
package.dependencies.append(Package.Dependency.Package(url: "https://github.com/Zewo/CUUID.git", majorVersion: 1))
#endif
