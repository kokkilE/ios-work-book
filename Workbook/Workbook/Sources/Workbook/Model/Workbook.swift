//
//  Workbook.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import Foundation
import Combine

struct Workbook: Hashable {
    private let identifier = UUID()
    private var title: String
    var problemContainer: ProblemContainer
    
    init(title: String, problems: [Problem]) {
        self.title = title
        self.problemContainer = ProblemContainer(problems: problems)
    }
    
    mutating func addProblem(_ problem: Problem) {
        problemContainer.problems.append(problem)
    }
    
    func getTitle() -> String {
        return title
    }
    
    static func == (lhs: Workbook, rhs: Workbook) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

final class ProblemContainer: Hashable {
    @Published var problems: [Problem]
    
    init(problems: [Problem]) {
        self.problems = problems
    }
    
    static func == (lhs: ProblemContainer, rhs: ProblemContainer) -> Bool {
        return lhs.problems == rhs.problems
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(problems)
    }
}
