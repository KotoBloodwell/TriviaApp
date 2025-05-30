//
//  Item.swift
//  TriviaApp
//
//  Created by Juliana Loaiza Labrador on 6/07/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
