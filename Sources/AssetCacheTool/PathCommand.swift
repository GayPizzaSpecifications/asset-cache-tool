//
//  PathCommand.swift
//
//
//  Created by Kenneth Endfinger on 10/23/21.
//

import ArgumentParser
import Foundation

struct PathCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "path",
        abstract: "Print the cache path."
    )

    func run() throws {
        print(AssetCacheCommand.cache!.url.path)
    }
}
