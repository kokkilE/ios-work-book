//
//  ProblemManager.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/19.
//

import Foundation

final class ProblemManager {
    static let shared = ProblemManager()
    
    private var problemList = [Problem]() {
        didSet {
            print(problemList)
        }
    }
    
    private init() {}

    func addProblem(_ problem: Problem) {
        problemList.append(problem)
    }
}
