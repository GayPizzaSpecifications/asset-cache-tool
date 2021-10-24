//
//  AssetCacheCommand.swift
//
//
//  Created by Kenneth Endfinger on 10/23/21.
//

import ArgumentParser
import Foundation

struct AssetCacheCommand: ParsableCommand {
    static var cache: AssetCache?

    static var configuration = CommandConfiguration(
        commandName: "AssetCacheTool",
        abstract: "Apple Asset Cache Utility",
        version: "1.0.0",
        subcommands: [
            PrintCachePathCommand.self,
            ListAssetsCommand.self,
            ReassembleCacheCommand.self,
            FindCachesCommand.self
        ]
    )

    @Option(name: .customShort("p"), help: "Asset Cache Path")
    var assetCachePath: String?

    func validate() throws {
        if let assetCacheURL = try getAssetCache() {
            AssetCacheCommand.cache = AssetCache(assetCacheURL)
        }
    }

    private func getAssetCache() throws -> URL? {
        if assetCachePath != nil {
            return URL(fileURLWithPath: assetCachePath!)
        }

        let foundAssetCaches = try AssetCacheFinder.find()

        if foundAssetCaches.isEmpty {
            return nil
        }

        return foundAssetCaches.first!
    }
}
