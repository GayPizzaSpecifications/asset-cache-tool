// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "AssetCacheTool",
    products: [
        .executable(name: "asset-cache-tool", targets: ["AssetCacheTool"]),
        .library(name: "AssetCacheLibrary", type: .static, targets: ["AssetCacheLibrary"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.4"),
        .package(url: "https://github.com/stephencelis/SQLite.swift", .revision("a4c1d1dab2a89f3bdd6f2741f9fe7691f10cf8a5"))
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
