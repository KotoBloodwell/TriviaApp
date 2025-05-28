//
//  SelectionButton.swift
//  TriviaApp
//
//  Created by Juliana Loaiza Labrador on 11/07/24.
//

import SwiftUI

struct SelectionButton: View {
    var text: String
    var answerButtonState: AnswerButtonState = .unselected
    var action: (()-> Void)?

    var body: some View {

        Button(action: {
            action?()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(answerButtonState.backgroundColor)
                    .stroke(answerButtonState.tintColor, lineWidth: 2)

                HStack {
                    Text(text)
                        .fontWeight(.bold)
//                        .foregroundColor(answerButtonState.tintColor)

                    answerButtonState.icon
//                        .foregroundStyle(answerButtonState.tintColor)
                }
            }
        })
        .foregroundStyle(answerButtonState.tintColor)
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
    }
}

enum AnswerButtonState {
    case correct, incorrect, selected, unselected, discarded
//
//    var textColor: Color {
//        return Color.mint
//    }

    var icon: Image {
        switch self {
        case .correct:
            return Image(systemName: "checkmark.circle.fill")
        case .incorrect, .discarded:
            return Image(systemName: "xmark.circle.fill")
        case .selected:
            return Image(systemName: "checkmark.circle.fill")
        case .unselected:
            return Image(systemName: "circle")
        }
    }

    var tintColor: Color {
        switch self {
        case .correct:
            return Color.midGreen
        case .incorrect:
            return Color.midRed
        case .selected, .unselected:
            return Color.darkMint
        case .discarded:
            return Color.midGray
        }
    }

    var backgroundColor: Color {
        switch self {
        case .correct:
            return Color.lightGreen
        case .incorrect:
            return Color.lightRed
        case .selected, .unselected:
            return Color.lightMint
        case .discarded:
            return Color.lightGray
        }
    }
}

#Preview {
    VStack {
        SelectionButton(text: "Akali",answerButtonState: .correct)
        SelectionButton(text: "Akali",answerButtonState: .incorrect)
        SelectionButton(text: "Akali",answerButtonState: .selected)
        SelectionButton(text: "Akali",answerButtonState: .unselected)
        SelectionButton(text: "Akali",answerButtonState: .discarded)

    }
}
