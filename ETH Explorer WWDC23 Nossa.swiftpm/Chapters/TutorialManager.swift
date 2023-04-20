//
//  TutorialManager.swift
//  
//
//  Created by Alessio Nossa on 20/04/2023.
//

import Combine

class TutorialManager: ObservableObject {
    
    @Published var selectedChapter: Chapter = .createWallet
    @Published var chapters: [Chapter] = Chapter.allCases
    
    @Published var currentPatch: Patch?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $selectedChapter.sink { [weak self] newChapter in
            switch newChapter {
            case .createWallet:
                self?.currentPatch = self?.createWalletPatch
            default:
                self?.currentPatch = nil
            }
        }.store(in: &cancellables)
    }
    
    // 1 - Create your wallet
    lazy var createWalletPatch: Patch = Patch(nodes: [], wires: Set<Wire>())
    @Published var mnemonicNodeId: NodeId?
    @Published var privateKeyNodeId: NodeId?
    @Published var addressNodeId: NodeId?
}
