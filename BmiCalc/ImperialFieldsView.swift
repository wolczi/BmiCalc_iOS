//
//  ImperialFieldsView.swift
//  BmiCalc
//
//  Created by Przemysław Wołczacki on 30/03/2023.
//

import SwiftUI

struct ImperialFieldsView: View {
    @EnvironmentObject private var calculatorViewModel: CalculatorViewModel
    @FocusState var focusedField: CalculatorViewModel.FocusedField?
    
    var body: some View {
        VStack {
            HStack {
                TextField("Feet", text: $calculatorViewModel.feetString)
                    .textFieldStyle(.roundedBorder)
                    .padding(.leading)
                    .numbersOnly($calculatorViewModel.feetString)
                    .focused($focusedField, equals: .ft)
                    .onChange(of: focusedField)  { calculatorViewModel.focusedField = $0 }
                    .onChange(of: calculatorViewModel.focusedField) { focusedField = $0 }
                    
                
                TextField("Inches", text: $calculatorViewModel.inchesString)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing)
                    .numbersOnly($calculatorViewModel.inchesString)
                    .focused($focusedField, equals: .inch)
                    .onChange(of: focusedField)  { calculatorViewModel.focusedField = $0 }
                    .onChange(of: calculatorViewModel.focusedField) { focusedField = $0 }
                    
            }
                
            TextField("Pounds", text: $calculatorViewModel.poundsString)
                .textFieldStyle(.roundedBorder)
                .padding()
                .numbersOnly($calculatorViewModel.poundsString)
                .focused($focusedField, equals: .lb)
                .onChange(of: focusedField)  { calculatorViewModel.focusedField = $0 }
                .onChange(of: calculatorViewModel.focusedField) { focusedField = $0 }
                
        }
    }
}

struct ImperialFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        ImperialFieldsView()
            .environmentObject(CalculatorViewModel())
    }
}
