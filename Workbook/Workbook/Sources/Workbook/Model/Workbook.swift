//
//  Workbook.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

struct Workbook: Hashable {
    private var title: String
    private var problems: [Problem]
    
    init(title: String, problems: [Problem]) {
        self.title = title
        self.problems = problems
    }
    
    mutating func addProblem(_ problem: Problem) {
        problems.append(problem)
    }
    
    func getTitle() -> String {
        return title
    }
}
