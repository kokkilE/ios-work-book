//
//  Workbook.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import Foundation
import Combine

final class Workbook: Hashable {
    private let identifier = UUID()
    private var title: String
    @Published private var problems: [Problem]
    
    init(title: String, problems: [Problem]) {
        self.title = title
        self.problems = problems
    }
    
    func requestProblemsPublisher() -> AnyPublisher<[Problem], Never> {
        return $problems.eraseToAnyPublisher()
    }
    
    func addProblem(_ problem: Problem) {
        if problems.contains(problem) { return }
        
        problems.append(problem)
    }
    
    func editProblem(with problem: Problem) {
        let endIndex = problems.endIndex
        
        for index in 0...endIndex {
            if problems[safe: index] == problem {
                problems[safe: index]?.overwrite(with: problem)
            }
        }
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getProblem(at index: Int) -> Problem? {
        return problems[safe: index]
    }
    
    static func == (lhs: Workbook, rhs: Workbook) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
