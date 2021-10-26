//
//  LocalCacheRegistration.swift
//
//
//  Created by Kenneth Endfinger on 10/25/21.
//

import Foundation

public enum LocalCacheRegistration {
    private static let cacheRegistrationConfigurationURL = URL(string: "http://suconfig.apple.com/resource/registration/v1/config.plist")!

    public static func fetchConfiguration() throws -> RegistrationConfiguration {
        let (data, _, error) = URLSession.shared.synchronousDataTask(with: URLRequest(url: cacheRegistrationConfigurationURL))
        if error != nil {
            throw error!
        }

        if data == nil {
            throw URLError(URLError.badServerResponse)
        }

        let dataAsString = String(data: data!, encoding: .utf8)!
        let actualConfigData = Data(base64Encoded: dataAsString.replacingOccurrences(of: "\n", with: ""))!
        let strippedPlistData = actualConfigData.stripSignedBytes()
        return try PropertyListDecoder().decode(RegistrationConfiguration.self, from: strippedPlistData)
    }

    public struct RegistrationConfiguration: Codable {
        public let certificateURL: String
        public let establishmentURL: String
        public let registrationURL: String
        public let deregistrationURL: String
        public let denyListURL: String
        public let blackListURL: String? // deprecated
        public let statisticsURL: String
        public let allowListedHosts: [String]
        public let whiteListedHosts: [String]? // deprecated
        public let allowListedDomains: [String]
        public let whiteListedDomains: [String]? // deprecated
        public let assetTypeMap: [AssetTypeEntry]
        public let mediaTypeMap: [MediaTypeMapping]
    }

    public struct AssetTypeEntry: Codable {
        public let hosts: [String]
        public let mappings: [AssetTypeMapping]

        public enum CodingKeys: String, CodingKey {
            case hosts = "host"
            case mappings = "map"
        }
    }

    public struct AssetTypeMapping: Codable {
        public let type: String
        public let namespaces: [String]?
        public let paths: [String]?

        public enum CodingKeys: String, CodingKey {
            case type
            case namespaces = "namespace"
            case paths = "path"
        }
    }

    public struct MediaTypeMapping: Codable {
        public let type: String
        public let paths: [String]?

        public enum CodingKeys: String, CodingKey {
            case type
            case paths = "path"
        }
    }
}
