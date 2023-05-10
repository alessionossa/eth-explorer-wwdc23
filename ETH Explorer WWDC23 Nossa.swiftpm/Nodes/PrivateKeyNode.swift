//
//  PrivateKeyNode.swift
//  
//
//  Created by Alessio Nossa on 20/04/2023.
//

import SwiftUI
import Combine
import UniformTypeIdentifiers

public class PrivateKeyNode: BaseNode {
    
    struct PrivateKeyMiddleView: View {
        @ObservedObject var node: PrivateKeyNode
        
        var stringKeyRepresentation: String? {
            guard let hexString =
                    node.valueUpdate?.value?.map({ String($0, radix: 16) }).joined() else { return nil }

            return "0x" + hexString
        }

        var body: some View {
            VStack {
                Text("\(stringKeyRepresentation ?? "")")
                    .font(.callout.monospaced())
                    .lineLimit(nil)
                    .frame(width: 150)
                
                Button("Copy") {
                    UIPasteboard.general.string = stringKeyRepresentation
                }
            }
            
        }
    }

    @Published var valueUpdate: ValueUpdate<[UInt8]>? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    override public init(name: String, position: CGPoint? = nil) {
        super.init(name: name, position: position)
        
        inputs = [
            Port(name: "Phrase", type: .input, valueType: [String].self, parentNodeId: id)
        ]
        
        outputs = [
            Port(name: "Private Key", type: .output, valueType: [UInt8].self, parentNodeId: id),
        ]
        
        titleBarColor = .brown
        
        middleView = AnyView(PrivateKeyMiddleView(node: self))
        
        if let intInput = inputs[0] as? Port<[String]> {
            intInput.$valueUpdate.sink { [weak self] phrase in
                guard let phraseStrArray = phrase?.value
                else { return }
                
                let seed = try? MnemonicGenerator.getSeed(phraseStrArray)
                
                self?.valueUpdate = ValueUpdate(seed)
            }
            .store(in: &cancellables)
        }
        
        if let intOutput = outputs[0] as? Port<[UInt8]> {
            $valueUpdate.assign(to: &intOutput.$valueUpdate)
        }
    }
}
