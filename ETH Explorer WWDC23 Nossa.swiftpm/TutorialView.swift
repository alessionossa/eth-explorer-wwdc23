//
//  TutorialView.swift
//  ETH Playground
//
//  Created by Alessio Nossa on 19/04/2023.
//

import SwiftUI

struct TutorialView: View {
    @Binding var selectedChapter: Chapter
    var chapters: [Chapter]
    
    var body: some View {
        VStack(spacing: 8) {
            ChapterSelectionView(
                selectedChapter: $selectedChapter,
                chapters: chapters
            )
            .padding(8)
            .zIndex(1)
            
            switch selectedChapter {
            case .createWallet:
                CreateWalletTextView()
            default:
                Text("Coming soon...")
            }
    
        }
        .animation(.easeInOut, value: selectedChapter)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(selectedChapter: .constant(.createWallet), chapters: Chapter.allCases)
    }
}
