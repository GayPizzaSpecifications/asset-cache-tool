//
//  RemoteCacheLocator.swift
//
//
//  Created by Alex Zenla on 10/24/21.
//

import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public enum RemoteCacheLocator {
    private static let locateEndpointURL = URL(string: "https://lcdn-locator.apple.com/lcdn/locate")!

    public static func locate(_ request: LocatorRequest) throws -> LocatorResponse {
        var urlRequest = URLRequest(url: locateEndpointURL)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try JSONEncoder().encode(request)
        let (data, _, error) = URLSession.shared.synchronousDataTask(with: urlRequest)
        if error != nil {
            throw error!
        }

        guard let decodedData = data else {
            throw URLError(URLError.cannotParseResponse)
        }
        return try JSONDecoder().decode(LocatorResponse.self, from: decodedData)
    }

    public struct LocatorRequest: Codable {
        public init(isRankedResults: Bool, locatorTag: String, localAddresses: [String], publicAddressRanges: [[String]], locatorSoftware: [RemoteCacheLocator.LocatorSoftware]) {
            self.isRankedResults = isRankedResults
            self.locatorTag = locatorTag
            self.localAddresses = localAddresses
            self.publicAddressRanges = publicAddressRanges
            self.locatorSoftware = locatorSoftware
        }

        public let isRankedResults: Bool
        public let locatorTag: String
        public let localAddresses: [String]
        public let publicAddressRanges: [[String]]
        public let locatorSoftware: [LocatorSoftware]

        public enum CodingKeys: String, CodingKey {
            case isRankedResults = "ranked-results"
            case locatorTag = "locator-tag"
            case localAddresses = "local-addresses"
            case publicAddressRanges = "public-address-ranges"
            case locatorSoftware = "locator-software"
        }
    }

    public struct LocatorSoftware: Codable {
        public init(build: String?, type: String?, name: String?, id: String?, version: String?, executable: String?) {
            self.build = build
            self.type = type
            self.name = name
            self.id = id
            self.version = version
            self.executable = executable
        }

        public let build: String?
        public let type: String?
        public let name: String?
        public let id: String?
        public let version: String?
        public let executable: String?
    }

    public struct LocatorResponse: Codable {
        public init(connectTimeout: Double, servers: [RemoteCacheLocator.LocatorServer], validityInterval: Int64) {
            self.connectTimeout = connectTimeout
            self.servers = servers
            self.validityInterval = validityInterval
        }

        public let connectTimeout: Double
        public let servers: [LocatorServer]
        public let validityInterval: Int64

        public enum CodingKeys: String, CodingKey {
            case connectTimeout = "connect-timeout"
            case servers
            case validityInterval = "validity-interval"
        }
    }

    public struct LocatorServer: Codable {
        public init(address: String, port: Int64, guid: String, version: String, connectTimeout: Double, details: RemoteCacheLocator.LocatorServerDetails, rank: Int64) {
            self.address = address
            self.port = port
            self.guid = guid
            self.version = version
            self.connectTimeout = connectTimeout
            self.details = details
            self.rank = rank
        }

        public let address: String
        public let port: Int64
        public let guid: String
        public let version: String
        public let connectTimeout: Double
        public let details: LocatorServerDetails
        public let rank: Int64

        public enum CodingKeys: String, CodingKey {
            case address
            case port
            case guid
            case version
            case connectTimeout = "connect-timeout"
            case details
            case rank
        }
    }

    public struct LocatorServerDetails: Codable {
        public init(capabilities: [String: Bool], cacheSizeInBytes: Int64, isAcPower: Bool, isPortable: Bool, localNetworkDetails: [RemoteCacheLocator.LocatorLocalNetworkDetails]) {
            self.capabilities = capabilities
            self.cacheSizeInBytes = cacheSizeInBytes
            self.isAcPower = isAcPower
            self.isPortable = isPortable
            self.localNetworkDetails = localNetworkDetails
        }

        public let capabilities: [String: Bool]
        public let cacheSizeInBytes: Int64
        public let isAcPower: Bool
        public let isPortable: Bool
        public let localNetworkDetails: [LocatorLocalNetworkDetails]

        public enum CodingKeys: String, CodingKey {
            case capabilities
            case cacheSizeInBytes = "cache-size"
            case isAcPower = "ac-power"
            case isPortable = "is-portable"
            case localNetworkDetails = "local-network"
        }
    }

    public struct LocatorLocalNetworkDetails: Codable {
        public init(speed: Int64, isWired: Bool) {
            self.speed = speed
            self.isWired = isWired
        }

        public let speed: Int64
        public let isWired: Bool

        public enum CodingKeys: String, CodingKey {
            case speed
            case isWired = "wired"
        }
    }
}
