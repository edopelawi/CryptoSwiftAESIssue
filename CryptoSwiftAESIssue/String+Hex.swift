//
//  String+Hex.swift
//  CryptoSwiftAESIssue
//
//  Created by Ricardo Pramana Suranta on 13/06/18.
//  Copyright © 2018 Ricardo Pramana Suranta. All rights reserved.
//

import Foundation

extension String {

	var hexaBytes: [UInt8] {

		var position = startIndex
		let endIndex = count / 2

		return (0..<endIndex).flatMap { _ in

			defer {
				position = index(position, offsetBy: 2)
			}

			return UInt8(self[position...index(after: position)], radix: 16)
		}
	}
	var hexaData: Data {
		return hexaBytes.data
	}
}

extension Collection where Iterator.Element == UInt8 {

	var data: Data {
		return Data(self)
	}

	var hexa: String {
		return map{ String(format: "%02X", $0) }.joined()
	}
}

