//
//  FindCachesCommand.swift
//
//
//  Created by Kenneth Endfinger on 10/24/21.
//

import ArgumentParser
import Foundation

struct FindCachesCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "find-caches",
        abstract: "List asset caches found on the system."
    )

    func run() throws {
        for assetCacheURL in try AssetCacheFinder.find() {
            print(assetCacheURL.path)
        }
    }
}
