//
//  RemoteAssetCache.swift
//
//
//  Created by Alex Zenla on 10/24/21.
//

import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct RemoteAssetCache {
    public let serverBaseURL: URL

    public init(_ url: URL) {
        serverBaseURL = url
    }

    public func download(_ originFileURL: URL, to targetFileURL: URL, headers: [String: String]? = nil) throws {
        var request = URLRequest(url: try downloadURL(for: originFileURL))

        if let headersToAdd = headers {
            for (key, value) in headersToAdd {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        let (downloadedFileURL, _, error) = URLSession.shared.synchronousDownloadTask(with: request)
        if error != nil {
            throw error!
        }

        if downloadedFileURL == nil {
            throw URLError(URLError.badServerResponse)
        }

        if FileManager.default.fileExists(atPath: targetFileURL.path) {
            try FileManager.default.removeItem(at: targetFileURL)
        }
        try FileManager.default.moveItem(at: downloadedFileURL!, to: targetFileURL)
    }

    public func downloadURL(for originFileURL: URL) throws -> URL {
        var cacheServerURLComponents = URLComponents(string: originFileURL.absoluteString)!
        let host = cacheServerURLComponents.host!
        let scheme = cacheServerURLComponents.scheme!
        let port: Int
        if cacheServerURLComponents.port != nil {
            port = cacheServerURLComponents.port!
        } else if originFileURL.scheme == "http" {
            port = 80
        } else if originFileURL.scheme == "https" {
            port = 443
        } else {
            throw URLError(URLError.badURL)
        }
        cacheServerURLComponents.scheme = "http"
        cacheServerURLComponents.port = serverBaseURL.port
        cacheServerURLComponents.host = serverBaseURL.host
        if cacheServerURLComponents.queryItems == nil {
            cacheServerURLComponents.queryItems = []
        }
        cacheServerURLComponents.queryItems!.append(URLQueryItem(name: "source", value: "\(host):\(port)"))
        cacheServerURLComponents.queryItems!.append(URLQueryItem(name: "sourceScheme", value: scheme))
        return cacheServerURLComponents.url!
    }
}
