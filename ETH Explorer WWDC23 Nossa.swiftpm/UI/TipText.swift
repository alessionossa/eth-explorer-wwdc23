//
//  TipText.swift
//  
//
//  Created by Alessio Nossa on 09/05/2023.
//

import SwiftUI

struct TipText: View {
    @State var text: String
    
    var body: some View {
        Text(text)
            .font(.callout)
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(8)
    }
}
