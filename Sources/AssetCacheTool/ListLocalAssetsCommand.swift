//
//  ListLocalAssetsCommand.swift
//
//
//  Created by Alex Zenla on 10/23/21.
//

import ArgumentParser
import Foundation

struct ListLocalAssetsCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "list-local-assets",
        abstract: "List assets inside the local cache."
    )

    @Flag(name: [.customShort("j"), .customLong("json")], help: "Enables JSON output.")
    var json: Bool = false

    func run() throws {
        for asset in try AssetCacheToolCommand.cache.listAllAssets() {
            if json {
                print(String(data: try JSONEncoder().encode(asset), encoding: .utf8)!)
            } else {
                print("\(asset.guid) namespace=\(asset.namespace ?? "default") index=\(asset.index ?? "unknown") uri=\(asset.uri)")
            }
        }
    }
}
