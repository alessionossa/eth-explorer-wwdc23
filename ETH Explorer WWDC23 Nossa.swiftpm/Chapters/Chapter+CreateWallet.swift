//
//  Chapter+CreateWallet.swift
//  
//
//  Created by Alessio Nossa on 20/04/2023.
//

import SwiftUI

struct CreateWalletTextView: View {
    
    @EnvironmentObject var tutorialManager: TutorialManager
        
    var body: some View {
        ScrollView(showsIndicators: true) {
            VStack(alignment: .leading, spacing: 8) {
                Group {
                    Text("To interact with the blockchain, you need to be able to sign messages cryptographically, and to do this you are going to create a cryptographic key. We'll create a cryptographic key and that’s all you actually have to keep in your wallet. In blockchains, in fact, your wallet doesn't store your assets (cryptocurrencies, tokens, NFTs, etc.), but rather a key that proves ownership of them.")
                         
                    Text("To be able to save this key easily, the key of the wallet will be generated using a mnemonic phrase, that is easy for humans to read. So, let’s add our first blocks!")
                    
                    HStack {
                        Button("Insert \"Mnemonic\" block", action: {
                            insertMnemonicBlock()
                        })
                        .disabled(tutorialManager.mnemonicNodeId != nil)
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    TipText(text: "💡 Activate the trigger to generate a new phrase")
                }
                
                
                Group {
                    Text("This phrase is used by a hash function (a one-way function that consistently generates the same output from a given input) to create our secret Private Key.")
                    
                    
                    HStack {
                        Button("Insert \"Private Key\" block", action: {
                            insertPrivateKeyBlock()
                        })
                        .disabled(tutorialManager.mnemonicNodeId == nil || tutorialManager.privateKeyNodeId != nil)
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    
                    TipText(text: "💡 Connect the output of \"Mnemonic\" to the input of \"Private Key\"")
                    
                    Text("From the Private Key, you can derive other necessary components, such as our wallet's public address. But due to some limitation in Swift Playgrounds, it is not possuble to visualize it at the moment.")
                    
                    HStack {
                        
                        Button("Insert \"Address\" block", action: {
                            insertAddressBlock()
                        })
                        .disabled(tutorialManager.privateKeyNodeId == nil || tutorialManager.addressNodeId != nil)
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    
                    Text("Great job! Now you have everything required to sign a message for the blockchain!")

                }
                
                VStack {
                    VStack {
                        Text("❓Do you want to see the result without going through all the steps?")
                            .font(.callout)
                        Divider()
                        Button("Show final solution") {
                            showFinalSolution()
                        }.padding(4)
                    }
                    .padding(6)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(8)
                
                
                    Button("Go to the next chapter") {
                        tutorialManager.selectedChapter = .signMessage
                    }
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity)


            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
    
    func resetPatch() {
        tutorialManager.createWalletPatch.reset()
    }
    
    func showFinalSolution() {
        resetPatch()
        
        let mnemonicNode = insertMnemonicBlock()
        let privateKeyNode = insertPrivateKeyBlock()
        
        let wire = Wire(from: OutputID(mnemonicNode, \.[0]), to: InputID(privateKeyNode, \.[0]))
        tutorialManager.createWalletPatch.connect(wire)
    }
    
    @discardableResult
    func insertMnemonicBlock() -> MnemonicNode {
        let triggerNode = TriggerButtonNode(name: "Trigger", position: .init(x: -200, y: -110))
        let mnemonicNode = MnemonicNode(name: "Mnemonic", position: .init(x: 50, y: -20))
        tutorialManager.createWalletPatch.nodes.append(triggerNode)
        tutorialManager.createWalletPatch.nodes.append(mnemonicNode)
        
        let wire = Wire(from: OutputID(triggerNode, \.[0]), to: InputID(mnemonicNode, \.[0]))
        
        tutorialManager.createWalletPatch.connect(wire)
        tutorialManager.createWalletPatch.nodeToShow = mnemonicNode
        tutorialManager.mnemonicNodeId = mnemonicNode.id
        
        return mnemonicNode
    }
    
    @discardableResult
    func insertPrivateKeyBlock() -> PrivateKeyNode {
        let privateKeyNode = PrivateKeyNode(name: "Private Key", position: .init(x: 340, y: 80))
        tutorialManager.createWalletPatch.nodes.append(privateKeyNode)
                            
        tutorialManager.createWalletPatch.nodeToShow = privateKeyNode
        tutorialManager.privateKeyNodeId = privateKeyNode.id
        
        return privateKeyNode
    }
    
    @discardableResult
    func insertAddressBlock() -> AddressNode {
        let addressNode = AddressNode(name: "Address", position: .init(x: 480, y: 120))
        tutorialManager.createWalletPatch.nodes.append(addressNode)
                            
        tutorialManager.createWalletPatch.nodeToShow = addressNode
        tutorialManager.addressNodeId = addressNode.id
        
        return addressNode
    }
}
