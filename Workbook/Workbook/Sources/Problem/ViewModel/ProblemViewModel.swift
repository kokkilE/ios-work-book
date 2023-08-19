//
//  ProblemViewModel.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/19.
//

import Foundation

final class ProblemViewModel {
    private let problemManager = ProblemManager.shared
    
    func addProblem(_ problem: Problem) {
        problemManager.addProblem(problem)
    }
}
