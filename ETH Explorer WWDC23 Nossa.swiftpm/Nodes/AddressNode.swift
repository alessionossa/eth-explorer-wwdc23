//
//  AddressNode.swift
//  
//
//  Created by Alessio Nossa on 09/05/2023.
//

import SwiftUI
import Combine

public class AddressNode: BaseNode {
    
    struct AddressMiddleView: View {
        @ObservedObject var node: AddressNode
        
        var body: some View {
            VStack {
                HStack {
                    if node.loading {
                        Spacer()
                        ProgressView()
                            .frame(width: 20, height: 20)
                            .progressViewStyle(.circular)
                        Spacer()
                    } else {
                        Text("\(node.valueUpdate?.value ?? "")")
                            .font(.callout.monospaced())
                            .lineLimit(nil)
                    }
                }.frame(width: 150)
                
                Button("Copy") {
                    UIPasteboard.general.string = node.valueUpdate?.value
                }
                .disabled(node.valueUpdate?.value == nil)
            }
        }
    }

    @Published var loading: Bool = false
    @Published var valueUpdate: ValueUpdate<String>? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    override public init(name: String, position: CGPoint? = nil) {
        super.init(name: name, position: position)
        
        inputs = [
            Port(name: "Private Key", type: .input, valueType: [UInt8].self, parentNodeId: id)
        ]
        
        outputs = [
            Port(name: "Address", type: .output, valueType: [String].self, parentNodeId: id)
        ]
        
        titleBarColor = Color(UIColor.systemPurple)
        
        middleView = AnyView(AddressMiddleView(node: self))
        
        if let privateKeyInput = inputs[0] as? Port<[UInt8]> {
            privateKeyInput.$valueUpdate.sink { [weak self] phrase in
                guard let strongSelf = self else { return }
                strongSelf.loading = true
                Task {
                    guard let privateKeyBytes = phrase?.value,
                          let seed = EthereumAdressCalculator.getEthereumAddress(bytes: privateKeyBytes)
                    else {
                        Task { @MainActor in
                            strongSelf.loading = false
                        }
                        return
                    }
                    
                    Task { @MainActor in
                        strongSelf.valueUpdate = ValueUpdate(seed)
                        strongSelf.loading = false
                    }
                }
            }
            .store(in: &cancellables)
        }
        
        if let addressOutput = outputs[0] as? Port<String> {
            $valueUpdate.assign(to: &addressOutput.$valueUpdate)
        }
    }
}
