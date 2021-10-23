//
//  Utilities.swift
//
//
//  Created by Kenneth Endfinger on 10/23/21.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? { self }
}
