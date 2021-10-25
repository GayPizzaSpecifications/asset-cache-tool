//
//  CacheRegistrationConfigurationCommand.swift
//
//
//  Created by Kenneth Endfinger on 10/25/21.
//

import ArgumentParser
import AssetCacheLibrary
import Foundation

struct CacheRegistrationConfigurationCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "cache-registration-configuration",
        abstract: "Fetch the cache registration configuration."
    )

    func run() throws {
        let configuration = try LocalCacheRegistration.fetchConfiguration()
        print(String(data: try JSONEncoder().encode(configuration), encoding: .utf8)!)
    }
}
