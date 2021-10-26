//
//  LocalCacheFinder.swift
//
//
//  Created by Kenneth Endfinger on 10/23/21.
//

import Foundation

#if os(macOS) || os(Linux)
    public enum LocalCacheFinder {
        @available(macOS 10.12, *)
        public static func find() throws -> [URL] {
            var results: [URL] = []

            if let rootAssetCacheURL = assetCacheDataURLAtRoot(URL(fileURLWithPath: "/")) {
                results.append(rootAssetCacheURL)
            }

            if let homeAssetCacheURL = assetCacheDataURLAtRoot(FileManager.default.homeDirectoryForCurrentUser) {
                results.append(homeAssetCacheURL)
            }

            guard let mountedVolumeURLs = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: [
                .volumeIsRootFileSystemKey
            ], options: .skipHiddenVolumes) else {
                return results
            }

            for url in mountedVolumeURLs {
                guard let assetCacheURL = assetCacheDataURLAtRoot(url) else {
                    continue
                }

                if try assetCacheURL.resourceValues(forKeys: [.volumeIsRootFileSystemKey]).volumeIsRootFileSystem! {
                    continue
                }

                results.append(assetCacheURL)
            }

            return results
        }

        public static func assetCacheDataURLAtRoot(_ root: URL) -> URL? {
            var actualRootPath = root.path
            if root.path.hasSuffix("/") {
                actualRootPath = String(root.path.prefix(root.path.count - 1))
            }
            let assetCacheDataURL = URL(fileURLWithPath: "\(actualRootPath)/Library/Application Support/Apple/AssetCache/Data")
            let assetCacheDatabaseURL = URL(fileURLWithPath: "\(assetCacheDataURL.path)/AssetInfo.db")
            if FileManager.default.fileExists(atPath: assetCacheDatabaseURL.path) {
                return assetCacheDataURL
            }
            return nil
        }
    }
#endif
