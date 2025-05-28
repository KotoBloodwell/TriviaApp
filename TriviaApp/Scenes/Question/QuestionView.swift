//
//  QuestionView.swift
//  TriviaApp
//
//  Created by Juliana Loaiza Labrador on 7/07/24.
//

import SwiftUI

struct QuestionView: View {
    @StateObject var viewModel: QuestionViewModel
    @State var showAlert: Bool = false

    init(viewModel: QuestionViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .top) {

            HStack {
                Button(action: {
                    self.showAlert = true
                }) {
                    Image(systemName: "chevron.backward")
                }
                Spacer()
            }

            VStack {
                HStack {
                    Text("\((viewModel.manager.currentQuestion + 1).description)/10")
                        .fontWeight(.bold)
                }
                .ignoresSafeArea(edges: .top)

                // MARK: - Question

                Text(viewModel.questionState.answerFeedBack)
                    .fontWeight(.bold)

                ZStack {
                    Circle()
                        .fill(viewModel.questionState.backgroundColor)

                    Text("\(viewModel.counter)")
                        .fontWeight(.bold)
                    Circle()
                        .stroke(
                            Color.darkOrange,
                            lineWidth: 19
                        )


                    Circle()
                        .stroke(
                            Color.lightOrange,
                            lineWidth: 15
                        )
                    Circle()
                        .trim(from: 0, to: (CGFloat((15-viewModel.counter))/15))
                        .stroke(
                            Color.darkOrange,
                            style: StrokeStyle(
                                lineWidth: 15,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear(duration: 1), value: (CGFloat(viewModel.counter)/15))

                }
                .frame(width: 80, height: 80)
                .padding(.bottom, -20)
                .zIndex(1)


                Text(viewModel.question.question)
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .fill(viewModel.questionState == .unanswered ? Color.lightOrange : viewModel.questionState.tintColor)
                        .stroke(Color.darkOrange, lineWidth: 2))
                    .zIndex(0)

                // MARK: - Answers

                ForEach(viewModel.question.answers, id: \.self) { answer in
                    HStack() {
                        SelectionButton(
                            text: answer,
                            answerButtonState: viewModel.getState(answer: answer),
                            action: {
                                viewModel.selectAnswer(selectedAnswer: answer)
                            }
                        )
                        .disabled(viewModel.questionState != .unanswered)
                        .frame(height: 70)
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)

                Spacer()

                // MARK: - Button

                Button(action: {
                    viewModel.manager.next(answer: viewModel.selectedAnswer)
                }, label: {
                    HStack {
                        Spacer()
                        Text("Next")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color.white)
                        Spacer()

                    }
                })
                .disabled(viewModel.questionState == .unanswered)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8))

            }

        }
        .foregroundColor(viewModel.questionState.tintColor)
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Do you want to leave?"),
                  message: Text("The changes will not be saved"), primaryButton: .default(Text("Quit")) {
                viewModel.manager.navigation.removeAll()
            }, secondaryButton: .cancel())
        }
        .navigationBarBackButtonHidden(true)
        .background(viewModel.questionState.backgroundColor)
    }
}

enum QuestionState {
    case unanswered, correct, incorrect, timeout

    var backgroundColor: Color {
        switch self {
        case .unanswered:
            return Color.midMint
        case .correct:
            return Color.lightGreen.opacity(0.5)
        case .incorrect:
            return Color.lightRed.opacity(0.5)
        case .timeout:
            return Color.midGray
        }
    }

    var tintColor: Color {
        switch self {
        case .unanswered, .timeout:
            return Color.darkGray
        case .correct:
            return Color.darkGreen
        case .incorrect:
            return Color.darkRed
        }
    }

    var answerFeedBack: String {
        switch self {
        case .unanswered:
            return " "
        case .correct:
            return "Correct!"
        case .incorrect:
            return "Incorrect answer"
        case .timeout:
            return "Time Out!"
        }
    }
}
