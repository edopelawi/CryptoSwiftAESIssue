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

		let salt = "1234567890aedefbc79654d99766ce08"
		let iv = "b987654321bdaef8765abde689adc876"
		let secretKey = "BADSVGuADAVEdgate100AFaLUHAJBUYEaegaetv124560980"

		do {
			let chiperKey = try generateKey(salt: salt, password: secretKey)
			let blockMode = CBC(iv: iv.hexaBytes)
			return try AES(key: chiperKey, blockMode: blockMode, padding: Padding.pkcs5)
		} catch {
			print("Failed to create chiper, error: \(error)")
			return nil
		}
	}

	private func generateKey(salt: String, password: String, keyLength: Int? = 128, iterations: Int = 1000) throws -> Array<UInt8> {

		let utf8Password = Array(password.utf8)
		let hexSalt = salt.hexaBytes

		let generator = try PKCS5.PBKDF2.init(
			password: utf8Password,
			salt: hexSalt,
			iterations: iterations,
			keyLength: keyLength,
			variant: .sha1
		)

		return try generator.calculate()
	}
}

