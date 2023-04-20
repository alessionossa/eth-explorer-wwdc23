//
//  IntroPopover.swift
//  ETH Explorer
//
//  Created by Alessio Nossa on 20/04/2023.
//

import SwiftUI

struct IntroPopover: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Ethereum Explorer")
                .font(.largeTitle)
                .padding(.bottom, 16)
            
            Text("Welcome to **Ethereum Explorer**, an engaging and interactive learning environment designed to help you explore the fundamental components of the Ethereum blockchain - the main blockchain of the web3 ecosystem. By utilizing a node-based UI, this playground offers a hands-on approach to understanding wallets, message signatures, and the process of exchanging assets on the blockchain.")
            
            Spacer()
            
            
            Button  {
                dismiss()
            } label: {
                Text("Get started!")
                    .font(.title)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
}

struct IntroPopover_Previews: PreviewProvider {
    static var previews: some View {
        IntroPopover()
    }
}
