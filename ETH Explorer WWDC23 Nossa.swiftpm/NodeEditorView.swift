//
//  NodeEditorView.swift
//  ETH Playground
//
//  Created by Alessio Nossa on 19/04/2023.
//

import SwiftUI

struct NodeEditorView: View {
    @StateObject var patch: Patch
    @State var selection = Set<NodeId>()

    var body: some View {
//        ZStack(alignment: .topTrailing) {
        NodeEditor(patch: patch,
                   backgroundColor: Color(UIColor.secondarySystemBackground),
                   selection: $selection)
                .onWireAdded { wire in
                    print("Added wire: \(wire)")
                }
                .onWireRemoved { wire in
                    print("Removed wire: \(wire)")
                }
//        }
    }
    
}
