//
//  RemoteAssetCache.swift
//
//
//  Created by Kenneth Endfinger on 10/24/21.
//

import Foundation

public struct RemoteAssetCache {
    public let serverBaseURL: URL

    public init(_ url: URL) {
        serverBaseURL = url
    }

    public func download(_ originFileURL: URL, to targetFileURL: URL) throws {
        let request = URLRequest(url: downloadURL(for: originFileURL))
        let (downloadedFileURL, _, error) = URLSession.shared.synchronousDownloadTask(with: request)
        if error != nil {
            throw error!
        }

        if downloadedFileURL == nil {
            throw URLError(URLError.badServerResponse)
        }

        try FileManager.default.moveItem(at: downloadedFileURL!, to: targetFileURL)
    }

    public func downloadURL(for originFileURL: URL) -> URL {
        var cacheServerURLComponents = URLComponents(string: originFileURL.absoluteString)!
        let host = cacheServerURLComponents.host!
        cacheServerURLComponents.scheme = "http"
        cacheServerURLComponents.port = serverBaseURL.port
        cacheServerURLComponents.host = serverBaseURL.host
        if cacheServerURLComponents.queryItems == nil {
            cacheServerURLComponents.queryItems = []
        }
        cacheServerURLComponents.queryItems!.append(URLQueryItem(name: "source", value: host))
        return cacheServerURLComponents.url!
    }
}
