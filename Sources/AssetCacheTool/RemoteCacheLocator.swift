//
//  RemoteCacheLocator.swift
//
//
//  Created by Kenneth Endfinger on 10/24/21.
//

import Foundation

struct RemoteCacheLocator {
    static let locateEndpointURL = URL(string: "https://lcdn-locator.apple.com/lcdn/locate")!

    static func locate(_ request: LocatorRequest) throws -> LocatorResponse {
        var urlRequest = URLRequest(url: locateEndpointURL)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try JSONEncoder().encode(request)
        let (data, _, error) = URLSession.shared.synchronousDataTask(with: urlRequest)
        if error != nil {
            throw error!
        }

        guard let decodedData = data else {
            throw "Failed to fetch data from URL response."
        }
        return try JSONDecoder().decode(LocatorResponse.self, from: decodedData)
    }

    struct LocatorRequest: Codable {
        let isRankedResults: Bool
        let locatorTag: String
        let localAddresses: [String]
        let publicAddressRanges: [[String]]
        let locatorSoftware: [LocatorSoftware]

        enum CodingKeys: String, CodingKey {
            case isRankedResults = "ranked-results"
            case locatorTag = "locator-tag"
            case localAddresses = "local-addresses"
            case publicAddressRanges = "public-address-ranges"
            case locatorSoftware = "locator-software"
        }
    }

    struct LocatorSoftware: Codable {
        let build: String?
        let type: String?
        let name: String?
        let id: String?
        let version: String?
        let executable: String?
    }

    struct LocatorResponse: Codable {
        let connectTimeout: Double
        let servers: [LocatorServer]
        let validityInterval: Int64

        enum CodingKeys: String, CodingKey {
            case connectTimeout = "connect-timeout"
            case servers
            case validityInterval = "validity-interval"
        }
    }

    struct LocatorServer: Codable {
        let address: String
        let port: Int64
        let guid: String
        let version: String
        let connectTimeout: Double
        let details: LocatorServerDetails
        let rank: Int64

        enum CodingKeys: String, CodingKey {
            case address
            case port
            case guid
            case version
            case connectTimeout = "connect-timeout"
            case details
            case rank
        }
    }

    struct LocatorServerDetails: Codable {
        let capabilities: [String: Bool]
        let cacheSizeInBytes: Int64
        let isAcPower: Bool
        let isPortable: Bool
        let localNetworkDetails: [LocatorLocalNetworkDetails]

        enum CodingKeys: String, CodingKey {
            case capabilities
            case cacheSizeInBytes = "cache-size"
            case isAcPower = "ac-power"
            case isPortable = "is-portable"
            case localNetworkDetails = "local-network"
        }
    }

    struct LocatorLocalNetworkDetails: Codable {
        let speed: Int64
        let isWired: Bool

        enum CodingKeys: String, CodingKey {
            case speed
            case isWired = "wired"
        }
    }
}
