//
//  ContentView.swift
//  BmiCalc
//
//  Created by Przemysław Wołczacki on 28/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @FocusState private var focusedField: FocusedField?
    @State private var selectedUnit: Units = .metric
    
    /* Metric Units */
    @State private var kilogramsString = ""
    @State private var centimetersString = ""
    
    /* Imperial Units */
    @State private var feetString = ""
    @State private var inchesString = ""
    @State private var poundsString = ""
    
    @State private var bmiResult = ""
    @State private var diagnosis = ""
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        
        UITextField.appearance().clearButtonMode = .whileEditing
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.systemBlue]
    }
    
    enum FocusedField {
        case weight, height
    }
    
    enum Units: String, CaseIterable {
        case metric = "Metric"
        case imperial = "Imperial"
    }
    
    func unableToCalculate(){
        self.bmiResult = "Complete the fields!"
        self.diagnosis = ""
    }
    
    var metricFieldsEmpty: Bool {
        return centimetersString.isEmpty || kilogramsString.isEmpty
    }
    
    var imperialFieldsEmpty: Bool {
        return feetString.isEmpty || inchesString.isEmpty || poundsString.isEmpty
    }
    
    func calculateBmi() {
        
        if selectedUnit == .metric {
            if (metricFieldsEmpty) {
                unableToCalculate()
            }else {
                let height = Double(centimetersString) ?? 0.0
                let weight = Double(kilogramsString) ?? 0.0
                
                makeDiagnosis(height: height, weight: weight)
            }
        }else {
            if (imperialFieldsEmpty) {
                unableToCalculate()
            }else {
        
                let feetToCm = (Double(feetString) ?? 0.0) * 30.48
                let inchesToCm = (Double(inchesString) ?? 0.0) * 2.54
                let poundsToKg = (Double(poundsString) ?? 0.0) * 0.45359237
                
                let height = feetToCm + inchesToCm
                let weight = poundsToKg
                
                makeDiagnosis(height: height, weight: weight)
            }
        }
    }
    
    func makeDiagnosis(height: Double, weight: Double) {
        let bmiResult = (weight/(height*height)) * 10000
        let roundedbmiResult = round(bmiResult * 100) / 100
        
        self.bmiResult = "BMI = \(roundedbmiResult)"
        
        switch roundedbmiResult{
            case 0..<18.5:
                diagnosis = "Underweight"
            case 18.5..<25:
                diagnosis = "Normal weight"
            case 25..<30:
                diagnosis = "Overweight"
            case 30...:
                diagnosis = "Obesity"
            default:
                diagnosis = "???"
        }
    }
    
    func clearStrings() {
        bmiResult = ""
        diagnosis = ""
        
        kilogramsString = ""
        centimetersString = ""
        
        feetString = ""
        inchesString = ""
        poundsString = ""
    }
    
    var body: some View {
        NavigationView{
            VStack {
                
                Picker("Choose units", selection: $selectedUnit) {
                    ForEach(Units.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .onChange(of: selectedUnit, perform: { _ in
                    clearStrings()
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                
                    if(selectedUnit == .metric) {
                        VStack {
                            TextField("Centimeters", text: $centimetersString)
                                .numbersOnly($centimetersString)
                                .focused($focusedField, equals: .height)
                                .textFieldStyle(.roundedBorder)
                                .padding([.leading, .trailing])
                            
                            TextField("Kilograms", text: $kilogramsString)
                                .numbersOnly($kilogramsString)
                                .focused($focusedField, equals: .weight)
                                .textFieldStyle(.roundedBorder)
                                .padding()
                        }
                        
                    }else {
                        VStack {
                            HStack {
                                TextField("Feet", text: $feetString)
                                    .numbersOnly($feetString)
                                    .focused($focusedField, equals: .height)
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.leading)
                                
                                TextField("Inches", text: $inchesString)
                                    .numbersOnly($inchesString)
                                    .focused($focusedField, equals: .height)
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.trailing)
                            }
                                
                            TextField("Pounds", text: $poundsString)
                                .numbersOnly($poundsString)
                                .focused($focusedField, equals: .weight)
                                .textFieldStyle(.roundedBorder)
                                .padding()
                        }
                        
                    }
                
            
                if !bmiResult.isEmpty {
                    VStack{
                        Text(bmiResult)
                        Text(diagnosis)
                    }
                    .padding()
                }
                
                Button("Calculate") {
                    focusedField = nil
                    
                    calculateBmi()
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
                        focusedField = nil
                        
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
    }
}
