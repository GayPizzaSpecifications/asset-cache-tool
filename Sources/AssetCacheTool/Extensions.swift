//
//  Extensions.swift
//
//
//  Created by Alex Zenla on 10/23/21.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? { self }
}
