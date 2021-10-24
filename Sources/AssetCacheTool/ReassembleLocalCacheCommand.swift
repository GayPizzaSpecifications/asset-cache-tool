//
//  ReassembleLocalCacheCommand.swift
//
//
//  Created by Kenneth Endfinger on 10/23/21.
//

import ArgumentParser
import Foundation

struct ReassembleLocalCacheCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "reassemble-local-cache",
        abstract: "Reassemble cached files in the local cache into a clean structure."
    )

    @Option(name: .customShort("d"), help: "Target Directory Path")
    var targetDirectoryPath: String = "cache"

    func run() throws {
        for asset in try AssetCacheToolCommand.cache.listAllAssets() {
            if asset.namespace != nil {
                continue
            }

            let sourceFileURL = AssetCacheToolCommand.cache.urlForAsset(asset)
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
