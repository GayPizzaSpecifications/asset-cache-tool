//
//  DownloadRemoteCacheCommand.swift
//
//
//  Created by Kenneth Endfinger on 10/24/21.
//

import ArgumentParser
import AssetCacheLibrary
import Foundation

struct DownloadRemoteCacheCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "download-remote-cache",
        abstract: "Download a file from a remote cache."
    )

    @Option(name: [.customShort("c"), .customLong("remote-cache-url")], help: "Remote Cache URL")
    var remoteCacheURL: String

    @Argument(help: "Origin URL")
    var originFileURL: String

    @Argument(help: "Download File Path")
    var targetFilePath: String

    func run() throws {
        guard let realRemoteCacheURL = URL(string: remoteCacheURL) else {
            throw "Failed to parse remote cache url."
        }

        guard let realOriginFileURL = URL(string: originFileURL) else {
            throw "Failed to parse origin url."
        }

        let targetFileURL = URL(fileURLWithPath: targetFilePath)

        let cache = RemoteAssetCache(realRemoteCacheURL)
        try cache.download(realOriginFileURL, to: targetFileURL)
    }
}
