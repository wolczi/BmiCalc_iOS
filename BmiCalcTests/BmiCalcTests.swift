//
//  BmiCalcTests.swift
//  BmiCalcTests
//
//  Created by Przemysław Wołczacki on 28/03/2023.
//

import XCTest
@testable import BmiCalc

final class BmiCalcTests: XCTestCase {

    func testCalculateBmiInMetricUnits() {
        let calculatorViewModel = CalculatorViewModel()
        
        calculatorViewModel.selectedUnit = .metric
        calculatorViewModel.centimetersString = "186"
        calculatorViewModel.kilogramsString = "50"
        calculatorViewModel.calculateBmi()
        
        XCTAssertEqual(calculatorViewModel.bmiResult, "BMI = 14.45")
        XCTAssertEqual(calculatorViewModel.diagnosis, "Underweight")
    }
    
    func testCalculateBmiInImperialUnits() {
        let calculatorViewModel = CalculatorViewModel()
        
        calculatorViewModel.selectedUnit = .imperial
        calculatorViewModel.feetString = "5"
        calculatorViewModel.inchesString = "10"
        calculatorViewModel.poundsString = "160"
        calculatorViewModel.calculateBmi()
        
        XCTAssertEqual(calculatorViewModel.bmiResult, "BMI = 22.96")
        XCTAssertEqual(calculatorViewModel.diagnosis, "Normal weight")
    }
    
    func testCalculateBmiWhenFieldsAreEmpty() {
        let calculatorViewModel = CalculatorViewModel()
        
        calculatorViewModel.calculateBmi()
        
        XCTAssertEqual(calculatorViewModel.bmiResult, "Complete the fields!")
    }
    
    func testCalculateBmiWhenNotAllFieldsAreFullFilled() {
        let calculatorViewModel = CalculatorViewModel()
        
        calculatorViewModel.selectedUnit = .metric
        calculatorViewModel.centimetersString = "186"
        calculatorViewModel.calculateBmi()
        
        XCTAssertEqual(calculatorViewModel.bmiResult, "Complete the fields!")
    }

}
