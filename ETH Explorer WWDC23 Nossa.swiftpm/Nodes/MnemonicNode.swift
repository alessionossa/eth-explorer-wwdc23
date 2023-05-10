//
//  MnemonicNode.swift
//  
//
//  Created by Alessio Nossa on 20/04/2023.
//

import SwiftUI
import Combine

public class MnemonicNode: BaseNode {
    
    struct MnemonicMiddleView: View {
        @ObservedObject var node: MnemonicNode
        
        var body: some View {
            Text("\(node.valueUpdate?.value?.joined(separator: " ") ?? "")")
                .font(.callout.monospaced())
                .lineLimit(nil)
                .frame(width: 150)
        }
    }

//    @Published var value: Int? = nil
    @Published var valueUpdate: ValueUpdate<[String]>? = nil
    
    var triggerCancellable: AnyCancellable?
    
    override public init(name: String, position: CGPoint? = nil) {
        super.init(name: name, position: position)
        
        inputs = [
            Port(name: "Trigger", type: .input, valueType: Void.self, parentNodeId: id)
        ]
        
        outputs = [
            Port(name: "Phrase", type: .output, valueType: [String].self, parentNodeId: id)
        ]
        
        titleBarColor = .brown
        
        middleView = AnyView(MnemonicMiddleView(node: self))
        
        if let intInput = inputs[0] as? Port<Void> {
            triggerCancellable = intInput.$valueUpdate
                .filter({ $0 != nil })
                .sink { [weak self] _ in
                    
                    let randomMnemonic = try? MnemonicGenerator.generateMnemonicPhrase()
                    self?.valueUpdate = ValueUpdate(randomMnemonic)
            }
        }
        
        if let intOutput = outputs[0] as? Port<[String]> {
            $valueUpdate.assign(to: &intOutput.$valueUpdate)
        }
    }
}
