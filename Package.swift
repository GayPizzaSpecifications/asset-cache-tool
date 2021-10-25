// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "AssetCacheTool",
    products: [
        .executable(name: "AssetCacheTool", targets: ["AssetCacheTool"]),
        .library(name: "AssetCacheLibrary", type: .static, targets: ["AssetCacheLibrary"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/stephencelis/SQLite.swift", from: "0.13.0")
    ],
    targets: [
        .target(
            name: "AssetCacheTool",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .target(name: "AssetCacheLibrary")
            ]
        ),
        .target(
            name: "AssetCacheLibrary",
            dependencies: [
                .product(name: "SQLite", package: "SQLite.swift")
            ]
        )
    ]
)
