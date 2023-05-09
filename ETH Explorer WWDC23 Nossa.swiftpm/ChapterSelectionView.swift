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
    private let verticalPadding: CGFloat = 8
    private var cornerRadius: CGFloat {
        get { height / 2 }
    }
    @State private var isExpanded = false
    
    
    var body: some View {
        
        VStack {
            VStack(alignment: .center, spacing: 0) {
                ForEach(chapters, id: \.rawValue) { chapter in
                    if isExpanded || chapter == selectedChapter {
                        HStack(spacing: 8) {
                            Text("\(chapter.rawValue) - \(chapter.title)")
                                .font(
                                    .system(.title2,
                                            design: .rounded,
                                            weight: (chapter == selectedChapter) ? .black : .regular)
                                )
                                .opacity(chapter.isEnabled ? 1.0 : 0.5)
                                .onTapGesture {
                                    let shouldSelectChapter = isExpanded
                                    isExpanded.toggle()
                                    
                                    if shouldSelectChapter {
                                        selectedChapter = chapter
                                    }
                                }

                            .disabled(!chapter.isEnabled)
                        .frame(height: height)
                            if !isExpanded {
                                Image(systemName: "chevron.up.chevron.down")
                                    .font(.system(.title2))
                            }
                        }
                        
                        if isExpanded && chapter != chapters.last {
                            Divider()
                        }
                    }
                    
                }
            }
            .fixedSize()
            .padding(.horizontal, cornerRadius)
            .padding(.vertical, verticalPadding)
            .background {
                if isExpanded {
                    VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
        .frame(height: height + verticalPadding * 2, alignment: .top)
        .animation(.easeOut, value: isExpanded)
    }
}

struct ChapterSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterSelectionView(selectedChapter: .constant(.createWallet), chapters: Chapter.allCases)
    }
}
