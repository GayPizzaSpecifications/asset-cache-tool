//
//  Extensions.swift
//
//
//  Created by Kenneth Endfinger on 10/24/21.
//

import Foundation

internal extension URLSession {
    func synchronousDataTask(with request: URLRequest) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        let semaphore = DispatchSemaphore(value: 0)

        let dataTask = self.dataTask(with: request) {
            data = $0
            response = $1
            error = $2

            semaphore.signal()
        }
        dataTask.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        return (data, response, error)
    }

    func synchronousDownloadTask(with request: URLRequest) -> (URL?, URLResponse?, Error?) {
        var url: URL?
        var response: URLResponse?
        var error: Error?

        let semaphore = DispatchSemaphore(value: 0)

        let downloadTask = self.downloadTask(with: request) {
            url = $0
            response = $1
            error = $2

            semaphore.signal()
        }
        downloadTask.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        return (url, response, error)
    }
}
