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
        
        VStack {
            VStack(alignment: .center, spacing: 0) {
                ForEach(chapters, id: \.rawValue) { chapter in
                    if isExpanded || chapter == selectedChapter {
                        Button("\(chapter.rawValue) - \(chapter.title)", action: {
                            let shouldSelectChapter = isExpanded
                            isExpanded.toggle()
                            
                            if shouldSelectChapter {
                                selectedChapter = chapter
                            }
                        })
                        .disabled(!chapter.isEnabled)
                        .frame(height: height)
                        
                        if isExpanded && chapter != chapters.last {
                            Divider()
                        }
                    }
                    
                }
            }
            .fixedSize()
            .padding(.horizontal, cornerRadius)
            .padding(.vertical, 8)
            .background(Material.ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
        .frame(height: height, alignment: .top)
        .animation(.easeOut, value: isExpanded)
    }
}

struct ChapterSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterSelectionView(selectedChapter: .constant(.createWallet), chapters: Chapter.allCases)
    }
}
