//
//  ContentView.swift
//  BmiCalc
//
//  Created by Przemysław Wołczacki on 28/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var calculatorModel: CalculatorModel
    
    @FocusState var focusedField: CalculatorModel.FocusedField?
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        
        UITextField.appearance().clearButtonMode = .whileEditing
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.systemBlue]
    }
    
    var body: some View {
        NavigationView{
            VStack {
                
                Picker("Choose units", selection: $calculatorModel.selectedUnit) {
                    ForEach(CalculatorModel.Units.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .onChange(of: calculatorModel.selectedUnit, perform: { _ in
                    calculatorModel.clearStrings()
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                
                if(calculatorModel.selectedUnit == .metric) {
                    MetricFieldsView()
                }else {
                    ImperialFieldsView()
                }
                
            
                if !calculatorModel.bmiResult.isEmpty {
                    VStack{
                        Text(calculatorModel.bmiResult)
                        Text(calculatorModel.diagnosis)
                    }
                    .padding()
                }
                
                Button("Calculate") {
                    calculatorModel.focusedField = nil
                    
                    calculatorModel.calculateBmi()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                
                Spacer()
            }
            .navigationTitle("BMI Calculator")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Spacer()
                }
                
                ToolbarItem(placement: .keyboard) {
                    Button {
                        calculatorModel.focusedField = nil
                        
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CalculatorModel())
    }
}
