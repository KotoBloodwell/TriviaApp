//
//  QuizzManager.swift
//  TriviaApp
//
//  Created by Juliana Loaiza Labrador on 7/07/24.
//

import Foundation
import SwiftUI
import CoreData

class QuizManager: ObservableObject {
    @Published var navigation: [Navigation] = []
    @Published var players: [Player] = []
    @Published var currentPlayer: Player?

    private var questions: [Question] = []
    private(set) var currentQuestion: Int = 0
    private(set) var correctAnswers: Int = 0
    let persistenceController = PersistenceController.shared

    // Preview Initializer
    convenience init(players: [Player], name: String, correctAnswers: Int) {
        self.init()
        self.players = players
        self.correctAnswers = correctAnswers
    }

    func start(name: String) {
        Task {
            currentQuestion = 0
            correctAnswers = 0
            try await getQuestions()
            navigation.append(.quiz(quiz: questions[currentQuestion]))
            self.players = getPlayers()

            self.currentPlayer = Player(id: UUID(), name: name, correctAnswers: 0)
        }
    }

    func getPlayers() -> [Player] {
        let fetchRequest: NSFetchRequest<PlayerModel> = PlayerModel.fetchRequest()

        do {
            let objects = try persistenceController.container.viewContext.fetch(fetchRequest)
            return objects.compactMap {
                guard let id = $0.id, let name = $0.name else { return nil }
                return Player(id: id, name: name, correctAnswers: Int($0.correctAnswers))
            }
        } catch {
            print(error)
            return []
        }
    }

    func getQuestions() async throws {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&encode=url3986") else {
            throw TriviaError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let triviaResult = try JSONDecoder().decode(Trivia.self, from: data)
        questions = triviaResult.results
    }

    func next(answer: String) {
        guard var player = currentPlayer else { return }

        player.correctAnswers += answer == questions[currentQuestion].correctAnswer ? 1 : 0
        currentPlayer = player

        currentQuestion += 1

        guard currentQuestion != questions.count else {
            savePlayerInfo()
            navigation.append(.leaderBoard)
            return
        }

        navigation.append(.quiz(quiz: questions[currentQuestion]))
    }

    func savePlayerInfo() {
        guard let player = currentPlayer else { return }
        savePlayerDatabase(player: player)
        self.players = getPlayers()
    }

    func restart() {
        navigation = []
    }

    func savePlayerDatabase(player: Player) {
        let context = persistenceController.container.viewContext
        do {
            let object = PlayerModel(context: context)
            object.id = player.id
            object.name = player.name
            object.correctAnswers = Int32(player.correctAnswers)

            try context.save()
        } catch let error {
            print(error)
        }
    }
}

enum TriviaError: Error {
    case invalidURL
}

enum Navigation: Equatable, Hashable {
    case quiz(quiz: Question)
    case leaderBoard
}
