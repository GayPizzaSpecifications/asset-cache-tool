//
//  AssetCacheCommand.swift
//  
//
//  Created by Kenneth Endfinger on 10/23/21.
//

import Foundation
import ArgumentParser

@main
struct AssetCacheCommand: ParsableCommand {
    static var cache: AssetCache? = nil

    static var configuration = CommandConfiguration(
        commandName: "AssetCacheTool",
        abstract: "Apple Asset Cache Utility",
        version: "1.0.0",
        subcommands: [
            AssetCacheListCommand.self,
            AssetCacheReassembleCommand.self
        ]
    )

    @Option(name: .customShort("p"), help: "Asset Cache Path")
    var assetCachePath: String?

    func validate() throws {
        let assetCacheURL = getAssetCache()
        AssetCacheCommand.cache = AssetCache(assetCacheURL)
    }

    private func getAssetCache() -> URL {
        if assetCachePath != nil {
            return URL(fileURLWithPath: assetCachePath!)
        }

        let foundAssetCaches = AssetCacheFinder.find()

        if foundAssetCaches.isEmpty {
            AssetCacheCommand.exit(withError: "Asset Cache not found.")
        }

        return foundAssetCaches.first!
    }
}

struct AssetCacheListCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "list",
        abstract: "List cached assets."
    )

    @Flag(name: .customShort("j"), help: "Enable JSON Output")
    var json: Bool = false

    func run() throws {
        for asset in try AssetCacheCommand.cache!.listAllAssets() {
            if json {
                print(String(data: try JSONEncoder().encode(asset), encoding: .utf8)!)
            } else {
                print("\(asset.guid) namespace=\(asset.namespace ?? "default") index=\(asset.index ?? "unknown") uri=\(asset.uri)")
            }
        }
    }
}

struct AssetCacheReassembleCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "reassemble",
        abstract: "Reassemble cached files into a clean structure."
    )

    @Option(name: .customShort("d"), help: "Reassemble Directory Path")
    var targetDirectoryPath: String = "cache"

    func run() throws {
        for asset in try AssetCacheCommand.cache!.listAllAssets() {
            if asset.namespace != nil {
                continue
            }

            let sourceFileURL = AssetCacheCommand.cache!.urlForAsset(asset)
            let targetFileURL = URL(fileURLWithPath: "\(targetDirectoryPath)/\(asset.uri)")

            if !FileManager.default.fileExists(atPath: sourceFileURL.path) {
                continue
            }

            if FileManager.default.fileExists(atPath: targetFileURL.path) {
                continue
            }
            try FileManager.default.createDirectory(at: targetFileURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
            print("Copy \(asset.guid.uuidString) -> \(targetFileURL.path)")
            try FileManager.default.copyItem(at: sourceFileURL, to: targetFileURL)
        }
    }
}
