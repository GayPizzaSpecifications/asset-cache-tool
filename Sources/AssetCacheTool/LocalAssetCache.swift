//
//  LocalAssetCache.swift
//
//
//  Created by Kenneth Endfinger on 10/23/21.
//

import Foundation
import SQLite

struct LocalAssetCache {
    let url: URL
    let db: Connection

    init(_ url: URL) {
        self.url = url

        let databaseURL = url.appendingPathComponent("AssetInfo.db")
        do {
            db = try Connection(databaseURL.path)
        } catch {
            AssetCacheToolCommand.exit(withError: error)
        }
    }

    func listAllAssets() throws -> [Asset] {
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

    func urlForAsset(_ asset: Asset, part: UInt64 = 0) -> URL {
        URL(fileURLWithPath: "\(url.path)/\(asset.guid.uuidString)/\(part)")
    }

    struct Asset: Codable {
        let guid: UUID
        let index: String?
        let namespace: String?
        let uri: String
        let headers: [String: String]
        let totalBytes: UInt64

        func contentTypeHeader() -> String? {
            headers["Content-Type"] ?? headers["content-type"] ?? headers["CONTENT-TYPE"]
        }
    }
}
