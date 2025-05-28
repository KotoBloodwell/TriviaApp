//
//  QuestionViewModel.swift
//  TriviaApp
//
//  Created by Juliana Loaiza Labrador on 8/07/24.
//

import Foundation

class QuestionViewModel: ObservableObject {
    @Published var selectedAnswer: String = ""
    @Published var question: Question
    @Published var counter: Int = 15
    @Published var timeOut: Bool = false
    @Published var questionState: QuestionState = .unanswered
    var manager: QuizManager
    var timer: Timer?

    init(question: Question, manager: QuizManager) {
        self.question = question
        self.manager  = manager
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.counter > 0 {
                self.counter -= 1
            } else {
                self.timeOut = true
                self.timer?.invalidate()
                self.questionState = .timeout
            }
        }
    }

    func getState(answer: String) -> AnswerButtonState {
        guard self.questionState != .unanswered else { return .unselected }
        if answer == question.correctAnswer { return .correct }
        if answer == selectedAnswer { return .incorrect }

        return .discarded
    }


    func selectAnswer(selectedAnswer: String) {
        self.selectedAnswer = selectedAnswer
        self.timer?.invalidate()
        self.questionState = selectedAnswer == question.correctAnswer ? .correct : .incorrect
    }
}
