//
//  NumberFormatter+getPercent.swift
//  Workbook
//
//  Created by 조향래 on 2023/09/05.
//

import Foundation

extension NumberFormatter {
    func getPercent(numerator: Int, denominator: Int, digits: Int) -> Double {
        let correctAnswersRate: Double = Double(Double(numerator) / Double(denominator))
        let correctAnswersPercentage: Double = correctAnswersRate * 100
        let formattedCorrectAnswersPercentage = round(correctAnswersPercentage * pow(10, Double(digits))) / pow(10, Double(digits))
        
        return formattedCorrectAnswersPercentage
    }
}
