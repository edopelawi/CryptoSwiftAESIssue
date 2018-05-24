//
//  ViewController.swift
//  CryptoSwiftAESIssue
//
//  Created by Ricardo Pramana Suranta on 23/05/18.
//  Copyright © 2018 Ricardo Pramana Suranta. All rights reserved.
//

import UIKit
import CryptoSwift

final class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		testEncryption()
	}

	private func testEncryption() {

		let inputString = "2018-01-24T04:33:53Z"
		print("Input string: \(inputString)")

		guard let chiper = createChiper() else {
			return
		}

		do {
			let inputBytes = Array(inputString.utf8)
			let chiperResult = try chiper.encrypt(inputBytes)

			print("Chiper result byte: \(chiperResult)")

			let resultBase64 = Data(bytes: chiperResult).base64EncodedString()

			print("Chiper result Base64 string: \(resultBase64)")
		} catch {
			print("Failed to encrypt input, error: \(error)")
		}

	}


	private func createChiper() -> AES? {

		let key: [UInt8] = [
			0x1a, 0x2b, 0x3c, 0x4d,
			0x5e, 0x6f, 0x7a, 0x8b,
			0x1a, 0x2b, 0x3c, 0x4d,
			0x5e, 0x6f, 0x7a, 0x8b
		]

		let iv: [UInt8] = [
			0x00, 0xff, 0xde, 0x11,
			0x00, 0x57, 0xde, 0x9d,
			0x00, 0xff, 0xde, 0x11,
			0x00, 0x57, 0xde, 0x9d
		]

		let blockMode = BlockMode.CBC(iv: iv)

		do {
			return try AES(key: key, blockMode: blockMode, padding: Padding.pkcs5)
		} catch {
			print("Failed to create chiper, error: \(error)")
			return nil
		}
	}

}

