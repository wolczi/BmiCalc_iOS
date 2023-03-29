//
//  NumbersOnlyViewModifier.swift
//  BmiCalc
//
//  Created by Przemysław Wołczacki on 28/03/2023.
//

import SwiftUI
import Combine

struct NumbersOnlyViewModifier: ViewModifier{
    
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .keyboardType(.decimalPad)
            .onReceive(Just(text)) { newValue in
                let decimalSeparator: String = Locale.current.decimalSeparator ?? "."
                var numbers = "0123456789"
                
                numbers += decimalSeparator
                
                if newValue.components(separatedBy: decimalSeparator).count-1 > 1 || newValue.starts(with: decimalSeparator) {
                    let filtered = newValue
                    self.text = String(filtered.dropLast())
                }else {
                    let filtered = newValue.filter { numbers.contains($0) }
                    if filtered != newValue {
                        self.text = filtered
                    }
                }
            }
    }
    
}

extension View {
    func numbersOnly(_ text: Binding<String>) -> some View {
        self.modifier(NumbersOnlyViewModifier(text: text))
    }
    
}
