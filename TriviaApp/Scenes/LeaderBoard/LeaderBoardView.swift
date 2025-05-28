//
//  LeaderBoardView.swift
//  TriviaApp
//
//  Created by Juliana Loaiza Labrador on 12/07/24.
//

import SwiftUI

struct LeaderBoardView: View {
    @StateObject var viewModel: LeaderBoardViewModel

    init(viewModel: LeaderBoardViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack {
            ZStack {
                Rectangle().fill(Color.lightOrange)

                VStack(spacing: 8) {
                    Spacer()

                    Image(systemName: "fireworks")
                        .resizable()
                        .foregroundStyle(Color.white)
                        .frame(width: 120, height: 120)

                    if let currentPlayer = viewModel.manager.currentPlayer {
                        Text("You had \(currentPlayer.correctAnswers) correct answers")
                            .font(.headline)
                    }

                    if let currentPosition = viewModel.currentPosition {
                        Text("Your current position is \(currentPosition)")
                            .font(.subheadline)
                    }

                    Spacer()

                }
            }

            ZStack(alignment: .top) {
                Circle()
                    .fill(Color.midMint)
                    .frame(width: UIScreen.main.bounds.width * 2)
                    .padding(.top, -60)
                    .scaleEffect(x: 1.3)
                    .containerRelativeFrame(.horizontal)

                VStack {
                    ScrollView(.vertical) {
                        ForEach(Array(viewModel.playersOrdered.enumerated()), id: \.offset) { index, player in
                            VStack {
                                HStack {
                                    Text("\(index + 1).")
                                        .font(.subheadline)
                                        .fontWeight(.bold)

                                    Text(player.name)
                                        .font(.headline)
                                    Spacer()
                                    Text("\(player.correctAnswers)/10")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                }
                                .foregroundStyle(Color.darkMint)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.lightMint)
                                    .stroke(Color.darkMint, lineWidth: 1))
                            }
                            .padding(.top)
                            .padding(.horizontal, 20)
                        }
                    }

                    Button(action: {
                        viewModel.finishGame()
                    }, label: {
                        VStack {
                            Text("Play Again")
                                .fontWeight(.medium)
                                .foregroundStyle(Color.darkOrange)
                                .frame(maxWidth: .infinity)
                        }
                    })
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8)
                        .fill(Color.lightOrange)
                        .stroke(Color.darkOrange, lineWidth: 1))
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .foregroundColor(.darkOrange)
        .ignoresSafeArea()
        .background(Color.midMint)
    }
}

#Preview {
    let players = [Player(id: UUID(), name: "Juli", correctAnswers: 2),
                   Player(id: UUID(), name: "Alejo", correctAnswers: 5),
                   Player(id: UUID(), name: "Camila", correctAnswers: 3)]
    LeaderBoardView(viewModel: LeaderBoardViewModel(manager: QuizManager(players: players, name: "Rosa", correctAnswers: 3)))
}
