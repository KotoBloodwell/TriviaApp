//
//  HomeViewModel.swift
//  TriviaApp
//
//  Created by Juliana Loaiza Labrador on 17/07/24.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    private var cancellable: [AnyCancellable] = []
    @ObservedObject var manager = QuizManager()

    init() {
        self.manager.$navigation.receive(
            on: RunLoop.main
        ).sink { [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellable)
    }

    func startGame(name: String) {
       manager.start(name: name)
    }
}
