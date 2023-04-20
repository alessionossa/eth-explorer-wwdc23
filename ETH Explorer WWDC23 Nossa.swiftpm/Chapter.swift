//
//  Chapter.swift
//  ETH Explorer
//
//  Created by Alessio Nossa on 20/04/2023.
//

import SwiftUI

enum Chapter: Int, CaseIterable {
    case createWallet = 1
    case signMessage
    case verifySignature
    case receiveAssets
    case sendAssets
    
    var title: String {
        switch self {
        case .createWallet:
            return "Create your wallet"
        case .signMessage:
            return "Sign a message"
        case .verifySignature:
            return "Verify a message’s signature"
        case .receiveAssets:
            return "Receive assets"
        case .sendAssets:
            return "Send assets"
        }
    }
    
    var isEnabled: Bool {
        switch self {
        case .createWallet, .signMessage:
            return true
        default:
            return false
        }
    }
}
