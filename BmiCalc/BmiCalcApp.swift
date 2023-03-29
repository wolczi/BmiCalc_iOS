//
//  BmiCalcApp.swift
//  BmiCalc
//
//  Created by Przemysław Wołczacki on 28/03/2023.
//

import SwiftUI

@main
struct BmiCalcApp: App {
    @StateObject private var calculatorModel = CalculatorModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(calculatorModel)
        }
    }
}
