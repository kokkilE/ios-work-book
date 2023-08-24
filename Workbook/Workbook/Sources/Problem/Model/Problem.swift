//
//  Problem.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import Foundation

struct Problem: Hashable {
    enum ProblemType: Hashable {
        case shortAnswer
        case multipleChoice
        
        var description: String {
            switch(self) {
            case .shortAnswer:
                return "주관식"
            case .multipleChoice:
                return "객관식"
            }
        }
        
        var index: Int {
            switch(self) {
            case .shortAnswer:
                return 0
            case .multipleChoice:
                return 1
            }
        }
    }
    
    static let minimumExampleCount = 2
    let identifier = UUID()
    var problemType: ProblemType
    var question: String
    var example: [String]?
    var shortAnswer: String?
    var multipleAnswer: Set<Int>?
    var explanation: String?
    
    mutating func configureMultipleAnswer(_ multipleAnswer: Set<Int>) {
        self.multipleAnswer = multipleAnswer
    }
    
    mutating func overwrite(with problem: Problem) {
        problemType = problem.problemType
        question = problem.question
        example = problem.example
        shortAnswer = problem.shortAnswer
        multipleAnswer = problem.multipleAnswer
        explanation = problem.explanation
    }
    
    static func == (lhs: Problem, rhs: Problem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
