//
//  PrintCachePathCommand.swift
//
//
//  Created by Kenneth Endfinger on 10/23/21.
//

import ArgumentParser
import Foundation

struct PrintCachePathCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "print-cache-path",
        abstract: "Print the first detected cache path."
    )

    func run() throws {
        print(AssetCacheCommand.cache!.url.path)
    }
}
