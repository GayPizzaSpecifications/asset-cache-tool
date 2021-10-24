//
//  PrintLocalCachePathCommand.swift
//
//
//  Created by Kenneth Endfinger on 10/23/21.
//

import ArgumentParser
import Foundation

struct PrintLocalCachePathCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "print-local-cache-path",
        abstract: "Print the default local cache path."
    )

    func run() throws {
        print(AssetCacheToolCommand.cache.url.path)
    }
}
