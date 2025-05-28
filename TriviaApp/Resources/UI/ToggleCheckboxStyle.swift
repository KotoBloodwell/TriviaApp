//
//  ToggleCheckboxStyle.swift
//  TriviaApp
//
//  Created by Juliana Loaiza Labrador on 8/07/24.
//

import Foundation
import SwiftUI

struct ToggleCheckboxStyle: ToggleStyle {

    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(systemName: "checkmark.square")
                .symbolVariant(configuration.isOn ? .fill : .none)
        }

    }
}

extension ToggleStyle where Self == ToggleCheckboxStyle {
    static var checklist: ToggleCheckboxStyle { .init() }
}
