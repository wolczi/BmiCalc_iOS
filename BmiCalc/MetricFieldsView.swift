//
//  MetricFieldsView.swift
//  BmiCalc
//
//  Created by Przemysław Wołczacki on 30/03/2023.
//

import SwiftUI

struct MetricFieldsView: View {
    @EnvironmentObject private var calculatorModel: CalculatorModel
    @FocusState var focusedField: CalculatorModel.FocusedField?
    
    var body: some View {
        VStack {
            TextField("Centimeters", text: $calculatorModel.centimetersString)
                .textFieldStyle(.roundedBorder)
                .padding([.leading, .trailing])
                .numbersOnly($calculatorModel.centimetersString)
                .focused($focusedField, equals: .cm)
                .onChange(of: focusedField)  { calculatorModel.focusedField = $0 }
                .onChange(of: calculatorModel.focusedField) { focusedField = $0 }
            
            TextField("Kilograms", text: $calculatorModel.kilogramsString)
                .textFieldStyle(.roundedBorder)
                .padding()
                .numbersOnly($calculatorModel.kilogramsString)
                .focused($focusedField, equals: .kg)
                .onChange(of: focusedField)  { calculatorModel.focusedField = $0 }
                .onChange(of: calculatorModel.focusedField) { focusedField = $0 }
        }
    }
}

struct MetricFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricFieldsView()
            .environmentObject(CalculatorModel())
    }
}
