//
//  LeaderBoardViewModel.swift
//  TriviaApp
//
//  Created by Juliana Loaiza Labrador on 18/07/24.
//

import Foundation

class LeaderBoardViewModel: ObservableObject {
    var manager: QuizManager

    var playersOrdered: [Player] {
        self.manager.players.sorted { $0.correctAnswers > $1.correctAnswers }
    }

    var currentPosition: Int? {
        guard let currentPlayer = self.manager.currentPlayer else { return nil }
        return playersOrdered.firstIndex(where: { $0.id == currentPlayer.id }).map { $0 + 1 }
    }

    init(manager: QuizManager) {
        self.manager = manager
    }

    func finishGame() {
        manager.restart()
    }
}
