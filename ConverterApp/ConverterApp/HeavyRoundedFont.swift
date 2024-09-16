//
//  HeavyRoundedFont.swift
//  ConverterApp
//
//  Created by Himanshu Gupta on 16/09/24.
//

import SwiftUI

struct HeavyRoundedFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .heavy, design: .rounded))
    }
}

extension View {
    func heavyRoundedFont() -> some View {
        self.modifier(HeavyRoundedFont())
    }
}
