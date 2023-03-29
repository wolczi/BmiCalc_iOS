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
                        
                    }else {
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
