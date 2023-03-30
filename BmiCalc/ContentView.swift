//
//  ContentView.swift
//  BmiCalc
//
//  Created by Przemysław Wołczacki on 28/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var calculatorViewModel: CalculatorViewModel
    
    @FocusState var focusedField: CalculatorViewModel.FocusedField?
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        
        UITextField.appearance().clearButtonMode = .whileEditing
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.systemBlue]
    }
    
    var body: some View {
        NavigationView{
            VStack {
                
                Picker("Choose units", selection: $calculatorViewModel.selectedUnit) {
                    ForEach(CalculatorViewModel.Units.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .onChange(of: calculatorViewModel.selectedUnit, perform: { _ in
                    calculatorViewModel.clearStrings()
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                
                if(calculatorViewModel.selectedUnit == .metric) {
                    MetricFieldsView()
                }else {
                    ImperialFieldsView()
                }
                
            
                if !calculatorViewModel.bmiResult.isEmpty {
                    VStack{
                        Text(calculatorViewModel.bmiResult)
                        Text(calculatorViewModel.diagnosis)
                    }
                    .padding()
                }
                
                Button("Calculate") {
                    calculatorViewModel.focusedField = nil
                    
                    calculatorViewModel.calculateBmi()
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
                        calculatorViewModel.focusedField = nil
                        
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
            .environmentObject(CalculatorViewModel())
    }
}
