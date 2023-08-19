//
//  Problem.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

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
    let problemType: ProblemType
    let question: String
    let example: [String]?
    let shortAnswer: String?
    var multipleAnswer: Set<Int>?
    
    mutating func configureMultipleAnswer(_ multipleAnswer: Set<Int>) {
        self.multipleAnswer = multipleAnswer
    }
}
