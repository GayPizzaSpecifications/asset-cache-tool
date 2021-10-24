//
//  FindLocalCachesCommand.swift
//
//
//  Created by Kenneth Endfinger on 10/24/21.
//

import ArgumentParser
import Foundation

struct FindLocalCachesCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "find-local-caches",
        abstract: "Find caches that are located on the current system."
    )

    func run() throws {
        for assetCacheURL in try LocalCacheFinder.find() {
            print(assetCacheURL.path)
        }
    }
}
