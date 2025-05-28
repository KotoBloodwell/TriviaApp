//
//  HomeView.swift
//  TriviaApp
//
//  Created by Juliana Loaiza Labrador on 6/07/24.
//

import SwiftUI

struct HomeView: View {
    @State var nameTextfield: String = ""
    @StateObject var viewModel = HomeViewModel()
//    @StateObject var manager = QuizzManager()

    var body: some View {
        NavigationStack(path: $viewModel.manager.navigation) {

            VStack {
                Spacer()

                Image(systemName: "questionmark.circle")
                    .resizable()
                    .foregroundStyle(Color.lightMint)
                        .frame(width: 120, height: 120)

                Text("Quizz Game")
                    .foregroundStyle(Color.darkMint)
                    .font(.system(size: 25))
                    .fontWeight(.heavy)

                Spacer()

                VStack(alignment: .leading) {
                    Text("Enter your name")
                        .foregroundStyle(Color.darkMint)

                    TextField("", text: $nameTextfield)
                        .foregroundStyle(Color.darkMint)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                            .stroke(Color.darkMint).opacity(0.5))
                }.padding()

                Spacer()


                Button(action: {
                    viewModel.startGame(name: $nameTextfield.wrappedValue)
                }, label: {
                    Text("Start")
                        .fontWeight(.medium)
                        .foregroundStyle(Color.darkOrange)
                        .frame(maxWidth: .infinity)
                })
                .padding()
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill(Color.lightOrange)
                    .stroke(Color.darkOrange, lineWidth: 1))
                .padding()
                

                Spacer()
            }
            .onAppear(perform: {
                nameTextfield = ""
            })
            .foregroundStyle(Color.darkMint)
            .background(Color.midMint)
            .navigationDestination(for: Navigation.self) { navigation in
                switch navigation {
                case .quiz(let question):
                    QuestionView(viewModel: QuestionViewModel(question: question, manager: viewModel.manager))
                        .environmentObject(viewModel.manager)
                case .leaderBoard:
                    LeaderBoardView(viewModel: LeaderBoardViewModel(manager: viewModel.manager))
                        .environmentObject(viewModel.manager)
                }
            }
        }

    }
}

#Preview {
    HomeView()
}
