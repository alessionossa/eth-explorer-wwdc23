import SwiftUI

struct ETHSandboxMainView: View {
    
    @StateObject var tutorialManager = TutorialManager()
    
    @State private var showingIntroPopover = true
    
    var body: some View {
        VStack {
            GeometryReader { geometryProxy in
                HStack(alignment: .top, spacing: 1.0) {
                    TutorialView(selectedChapter: $tutorialManager.selectedChapter, chapters: tutorialManager.chapters)
                        .frame(width: geometryProxy.size.width * 0.4)
                    Divider()
                    
                    if let currentPatch = tutorialManager.currentPatch {
                        NodeEditorView(patch: currentPatch)
                    }
                    
                }
            }
        }
        .environmentObject(tutorialManager)
        .sheet(isPresented: $showingIntroPopover) {
            IntroPopover()
        }
    }
}
