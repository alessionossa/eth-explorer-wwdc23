//
//  ChapterSelectionView.swift
//  ETH Playground
//
//  Created by Alessio Nossa on 19/04/2023.
//

import SwiftUI

struct ChapterSelectionView: View {
    @Binding var selectedChapter: Chapter
    var chapters: [Chapter]
    private let height: CGFloat = 40
    private var cornerRadius: CGFloat {
        get { height / 2 }
    }
    @State private var isExpanded = false
    var body: some View {

            Picker("Select a chapter", selection: $selectedChapter) {
                ForEach(chapters, id: \.rawValue) { chapter in
                    Text("\(chapter.rawValue) - \(chapter.title)").tag(chapter)
                        .disabled(!chapter.isEnabled)
                }
            }
            .foregroundColor(Color(UIColor.label))
            .pickerStyle(.menu)
            .padding(8)
            .background(
                Color(UIColor.systemGray2)
                    .opacity(0.3)
                    .cornerRadius(16)
                    .blur(radius: 4)
            )
            .cornerRadius(16)
    }
}

struct ChapterSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterSelectionView(selectedChapter: .constant(.createWallet), chapters: Chapter.allCases)
    }
}
