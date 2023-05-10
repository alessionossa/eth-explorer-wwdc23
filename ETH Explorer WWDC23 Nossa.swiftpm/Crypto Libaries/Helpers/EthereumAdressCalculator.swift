//
//  EthereumAdressCalculator.swift
//  
//
//  Created by Alessio Nossa on 09/05/2023.
//

import EllipticCurveKit
import Foundation
import CryptoSwift
import Security

enum EthereumAdressCalculator {
    static func getEthereumAddress(bytes: [UInt8]) -> String? {
        
        let childKey  = ExtendedKey(Data(bytes), HDWallet(coin: .ethereum).derivationPath)
        let childKeyData = childKey.keyPair.privateKey.rawValue

        guard let privateKey = PrivateKey<Secp256k1>.init(base64: childKeyData) else {
            return nil
        }
        
        let publicKey = PublicKey(privateKey: privateKey)
        
        let publicKeyBytes = publicKey.data.uncompressed.dropFirst()
        
        // Hash the public key using Keccak-256
        let shaHash = SHA3(variant: .keccak256).calculate(for: Array(publicKeyBytes))
        
        let addressBytes = shaHash.suffix(20)
        // Convert address bytes to a hex string
        let address = addressBytes.map { String(format: "%02x", $0) }.joined()
            
        return "0x\(address)"
    }
}


enum MnemonicGenerator {
    static func generateMnemonicPhrase() throws -> [String] {
        let byteCount: Int = 32
        var bytes = [UInt8](repeating: 0, count: byteCount)
        let status = SecRandomCopyBytes(kSecRandomDefault, byteCount, &bytes)
        
        guard status == errSecSuccess else {
            throw KeychainError.randomGenerationFailed(status)
        }
        
        let entropy: ContiguousBytes = Data(bytes)
        
        let mnemonica = try Mnemonica.generate(from: entropy, glossary: .english)
        
        return mnemonica.words
    }
    
    static func getSeed(_ words: [String]) throws -> [UInt8] {
        let mnemonica = try Mnemonica(words)
        let digest = try mnemonica.digest(with: .ethereum())
        return digest.seed
    }
}

// Define an error type for random generation failure
enum KeychainError: Error {
    case randomGenerationFailed(OSStatus)
}
