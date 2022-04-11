//
//  TextFieldModifier.swift
//  Tests
//
//  Created by Andres camilo Raigoza misas on 11/04/22.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(12)
    }
}

