//
//  ImperialFieldsView.swift
//  BmiCalc
//
//  Created by Przemysław Wołczacki on 30/03/2023.
//

import SwiftUI

struct ImperialFieldsView: View {
    @EnvironmentObject private var calculatorModel: CalculatorModel
    @FocusState var focusedField: CalculatorModel.FocusedField?
    
    var body: some View {
        VStack {
            HStack {
                TextField("Feet", text: $calculatorModel.feetString)
                    .textFieldStyle(.roundedBorder)
                    .padding(.leading)
                    .numbersOnly($calculatorModel.feetString)
                    .focused($focusedField, equals: .ft)
                    .onChange(of: focusedField)  { calculatorModel.focusedField = $0 }
                    .onChange(of: calculatorModel.focusedField) { focusedField = $0 }
                    
                
                TextField("Inches", text: $calculatorModel.inchesString)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing)
                    .numbersOnly($calculatorModel.inchesString)
                    .focused($focusedField, equals: .inch)
                    .onChange(of: focusedField)  { calculatorModel.focusedField = $0 }
                    .onChange(of: calculatorModel.focusedField) { focusedField = $0 }
                    
            }
                
            TextField("Pounds", text: $calculatorModel.poundsString)
                .textFieldStyle(.roundedBorder)
                .padding()
                .numbersOnly($calculatorModel.poundsString)
                .focused($focusedField, equals: .lb)
                .onChange(of: focusedField)  { calculatorModel.focusedField = $0 }
                .onChange(of: calculatorModel.focusedField) { focusedField = $0 }
                
        }
    }
}

struct ImperialFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        ImperialFieldsView()
            .environmentObject(CalculatorModel())
    }
}
