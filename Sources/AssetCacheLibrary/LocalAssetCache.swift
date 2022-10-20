//
//  LocalAssetCache.swift
//
//
//  Created by Alex Zenla on 10/23/21.
//

import Foundation
import SQLite

public struct LocalAssetCache {
    public let url: URL
    private let db: Connection

    public init?(_ url: URL) {
        self.url = url

        let databaseURL = url.appendingPathComponent("AssetInfo.db")
        do {
            db = try Connection(databaseURL.path)
        } catch {
            return nil
        }
    }

    public func listAllAssets() throws -> [Asset] {
        var assets: [Asset] = []
        for row in try db.run("SELECT ZGUID, ZINDEX, ZNAMESPACE, ZURI, ZENTITYHEADERS, ZTOTALBYTES FROM ZASSET", []) {
            let guidAsString = row[0]! as! String
            let index = row[1] as? String
            let namespace = row[2] as? String
            let uri = row[3]! as! String
            let entityHeadersAsBlob = row[4] as! Blob
            let totalBytes = UInt64(row[5] as! Int64)

            let headers = try PropertyListDecoder().decode([String: String].self, from: Data(entityHeadersAsBlob.bytes))

            assets.append(Asset(
                guid: UUID(uuidString: guidAsString)!,
                index: index,
                namespace: namespace,
                uri: uri,
                headers: headers,
                totalBytes: totalBytes
            ))
        }
        return assets
    }

    public func urlForAsset(_ asset: Asset, part: UInt64 = 0) -> URL {
        URL(fileURLWithPath: "\(url.path)/\(asset.guid.uuidString)/\(part)")
    }

    public struct Asset: Codable {
        public init(guid: UUID, index: String?, namespace: String?, uri: String, headers: [String: String], totalBytes: UInt64) {
            self.guid = guid
            self.index = index
            self.namespace = namespace
            self.uri = uri
            self.headers = headers
            self.totalBytes = totalBytes
        }

        public let guid: UUID
        public let index: String?
        public let namespace: String?
        public let uri: String
        public let headers: [String: String]
        public let totalBytes: UInt64

        public func contentTypeHeader() -> String? {
            headers["Content-Type"] ?? headers["content-type"] ?? headers["CONTENT-TYPE"]
        }
    }
}
