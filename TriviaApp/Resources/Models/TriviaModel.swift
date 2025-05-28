//
//  TriviaModel.swift
//  TriviaApp
//
//  Created by Juliana Loaiza Labrador on 7/07/24.
//

import Foundation

struct Trivia: Codable {
    var responseCode: Int
    var results: [Question]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

struct Question: Codable, Equatable, Hashable {
    var type: String
    var difficulty: String
    var category: String
    var question: String
    var correctAnswer: String
    var incorrectAnswer: [String]
    var answers: [String]

    enum CodingKeys: String, CodingKey {
        case type
        case difficulty
        case category
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswer = "incorrect_answers"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.difficulty = try container.decode(String.self, forKey: .difficulty)
        self.category = try container.decode(String.self, forKey: .category)
        self.question = try container.decode(String.self, forKey: .question).removingPercentEncoding ?? ""
        self.correctAnswer = try container.decode(String.self, forKey: .correctAnswer).removingPercentEncoding ?? ""
        self.incorrectAnswer = try container.decode([String].self, forKey: .incorrectAnswer).compactMap { $0.removingPercentEncoding }
        self.answers = ([correctAnswer] + incorrectAnswer).shuffled()
    }

    init(type: String, difficulty: String, category: String, question: String, correctAnswer: String, incorrectAnswer: [String]) {
       self.type = type
       self.difficulty = difficulty
       self.category = category
       self.question = question
       self.correctAnswer = correctAnswer
       self.incorrectAnswer = incorrectAnswer
       self.answers = ([correctAnswer] + incorrectAnswer).shuffled()
   }

}
