//
//  MetricFieldsView.swift
//  BmiCalc
//
//  Created by Przemysław Wołczacki on 30/03/2023.
//

import SwiftUI

struct MetricFieldsView: View {
    @EnvironmentObject private var calculatorViewModel: CalculatorViewModel
    @FocusState var focusedField: CalculatorViewModel.FocusedField?
    
    var body: some View {
        VStack {
            TextField("Centimeters", text: $calculatorViewModel.centimetersString)
                .textFieldStyle(.roundedBorder)
                .padding([.leading, .trailing])
                .numbersOnly($calculatorViewModel.centimetersString)
                .focused($focusedField, equals: .cm)
                .onChange(of: focusedField)  { calculatorViewModel.focusedField = $0 }
                .onChange(of: calculatorViewModel.focusedField) { focusedField = $0 }
            
            TextField("Kilograms", text: $calculatorViewModel.kilogramsString)
                .textFieldStyle(.roundedBorder)
                .padding()
                .numbersOnly($calculatorViewModel.kilogramsString)
                .focused($focusedField, equals: .kg)
                .onChange(of: focusedField)  { calculatorViewModel.focusedField = $0 }
                .onChange(of: calculatorViewModel.focusedField) { focusedField = $0 }
        }
    }
}

struct MetricFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricFieldsView()
            .environmentObject(CalculatorViewModel())
    }
}
