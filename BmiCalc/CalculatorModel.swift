//
//  CalculatorModel.swift
//  BmiCalc
//
//  Created by Przemysław Wołczacki on 29/03/2023.
//

import Foundation
import SwiftUI

class CalculatorModel: ObservableObject {
    
    @Published var focusedField: FocusedField?
    
    enum FocusedField {
        case cm, kg, ft, inch, lb
    }
    
    @Published var selectedUnit: Units = .metric
    
    public enum Units: String, CaseIterable {
        case metric = "Metric"
        case imperial = "Imperial"
    }
    
    /* Metric Units */
    @Published var kilogramsString = ""
    @Published var centimetersString = ""
    
    /* Imperial Units */
    @Published var feetString = ""
    @Published var inchesString = ""
    @Published var poundsString = ""
    
    @Published var bmiResult = ""
    @Published var diagnosis = ""
    
    
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
}
