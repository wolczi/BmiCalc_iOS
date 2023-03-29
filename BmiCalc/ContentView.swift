//
//  ContentView.swift
//  BmiCalc
//
//  Created by Przemysław Wołczacki on 28/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @FocusState private var focusedField: FocusedField?
    
    @State private var weightString = ""
    @State private var heightString = ""
    
    @State private var result = ""
    @State private var diagnosis = ""
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    enum FocusedField {
        case weight, height
    }
    
    var body: some View {
        NavigationView{
            VStack {

                TextField("Enter your weight in kilograms", text: $weightString)
                    .numbersOnly($weightString)
                    .focused($focusedField, equals: .weight)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                TextField("Enter your height in centimeters", text: $heightString)
                    .numbersOnly($heightString)
                    .focused($focusedField, equals: .height)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                if !result.isEmpty {
                    VStack{
                        Text(result)
                        Text(diagnosis)
                    }
                        .padding()
                }
                
                Button("Calculate") {
                    if (heightString.isEmpty || weightString.isEmpty) {
                        self.result = "Complete the fields!"
                        
                        self.diagnosis = ""
                    }else {
                        let height = Double(heightString) ?? 0.0
                        let weight = Double(weightString) ?? 0.0
                        let result = (weight/(height*height)) * 10000
                        let roundedResult = round(result * 100) / 100
                        
                        self.result = "BMI = \(roundedResult)"
                        
                        switch roundedResult{
                            case 0..<18.5:
                                diagnosis = "Underweight"
                            case 18.5..<25:
                                diagnosis = "Normal weight"
                            case 25...:
                                diagnosis = "Overweight"
                            default:
                                diagnosis = "??"
                        }
                        
                    }
                
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
                        
                        if(heightString.last == "." || heightString.last == ","){
                            heightString += "0"
                        }
                        
                        if(weightString.last == "." || weightString.last == ","){
                            weightString += "0"
                        }
                        
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
