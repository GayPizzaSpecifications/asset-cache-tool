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
            PathCommand.self,
            ListCommand.self,
            ReassembleCommand.self
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
