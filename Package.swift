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
        .package(url: "https://github.com/stephencelis/SQLite.swift", .revision("e191c7d04583a1fd4e0f95e73bec2161a30e4857"))
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
