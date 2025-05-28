//
//  PlayerModel.swift
//  TriviaApp
//
//  Created by Juliana Loaiza Labrador on 16/07/24.
//

import Foundation

struct Player: Hashable {
    let id: UUID
    let name: String
    var correctAnswers: Int = 0
}
