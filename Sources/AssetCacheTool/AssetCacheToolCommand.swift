//
//  AssetCacheToolCommand.swift
//
//
//  Created by Alex Zenla on 10/23/21.
//

import ArgumentParser
import AssetCacheLibrary
import Foundation

struct AssetCacheToolCommand: ParsableCommand {
    static var configuredLocalCache: LocalAssetCache?

    static var cache: LocalAssetCache {
        if configuredLocalCache == nil {
            AssetCacheToolCommand.exit(withError: "Asset cache not found.")
        }
        return configuredLocalCache!
    }

    static var configuration = CommandConfiguration(
        commandName: "AssetCacheTool",
        abstract: "Apple Asset Cache Utility",
        version: "1.0.0",
        subcommands: [
            PrintLocalCachePathCommand.self,
            ListLocalAssetsCommand.self,
            ReassembleLocalCacheCommand.self,
            FindLocalCachesCommand.self,
            FindRemoteCachesCommand.self,
            DownloadRemoteCacheCommand.self,
            CacheRegistrationConfigurationCommand.self
        ]
    )

    @Option(name: [.customShort("p"), .customLong("local-cache-path")], help: "Local Asset Cache Path")
    var localCachePath: String?

    func validate() throws {
        if let assetCacheURL = try getLocalAssetCache() {
            AssetCacheToolCommand.configuredLocalCache = LocalAssetCache(assetCacheURL)
        }
    }

    private func getLocalAssetCache() throws -> URL? {
        if localCachePath != nil {
            return URL(fileURLWithPath: localCachePath!)
        }

        let foundAssetCaches: [URL]
        if #available(macOS 10.12, *) {
            foundAssetCaches = try LocalCacheFinder.find()
        } else {
            foundAssetCaches = []
        }

        if foundAssetCaches.isEmpty {
            return nil
        }

        return foundAssetCaches.first!
    }
}
