//
//  FindRemoteCachesCommand.swift
//
//
//  Created by Alex Zenla on 10/24/21.
//

import ArgumentParser
import AssetCacheLibrary
import Foundation

struct FindRemoteCachesCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "find-remote-caches",
        abstract: "Find caches that are located on the network."
    )

    @Option(name: [.customShort("l"), .customLong("local-ip-address")], help: "Local IP Address")
    var localIpAddresses: [String]

    @Flag(name: [.customShort("j"), .customLong("json")], help: "Enables JSON output.")
    var json: Bool = false

    func run() throws {
        let request = RemoteCacheLocator.LocatorRequest(
            isRankedResults: true,
            locatorTag: "",
            localAddresses: localIpAddresses,
            publicAddressRanges: [[]],
            locatorSoftware: [
                .init(
                    build: "https://github.com/kZenla/AssetCacheTool",
                    type: "system",
                    name: "AssetCacheTool",
                    id: nil,
                    version: "1.0.0",
                    executable: nil
                )
            ]
        )

        let response = try RemoteCacheLocator.locate(request)

        if json {
            print(String(data: try JSONEncoder().encode(response), encoding: .utf8)!)
        } else {
            for server in response.servers {
                print("GUID: \(server.guid)")
                print("  Address: \(server.address)")
                print("  Port: \(server.port)")
                print("  Version: \(server.version)")
                print("  Rank: \(server.rank)")

                let dataSizeFormatter = ByteCountFormatter()
                print("  Cache Size: \(dataSizeFormatter.string(fromByteCount: server.details.cacheSizeInBytes))")
            }
        }
    }
}
