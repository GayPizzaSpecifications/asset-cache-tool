// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "AssetCacheTool",
    platforms: [
        .macOS("11.0")
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/stephencelis/SQLite.swift", from: "0.13.0")
    ],
    targets: [
        .executableTarget(
            name: "AssetCacheTool",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SQLite", package: "SQLite.swift")
            ]
        )
    ]
)
