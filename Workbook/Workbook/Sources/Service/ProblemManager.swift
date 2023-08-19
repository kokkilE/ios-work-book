//
//  ProblemManager.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/19.
//

import Foundation
import Combine

final class ProblemManager {
    static let shared = ProblemManager()
    
    @Published private var problemList = [Problem]() {
        didSet {
            print(problemList)
        }
    }
        
    func requestProblemListPublisher() -> AnyPublisher<[Problem], Never> {
        return $problemList.eraseToAnyPublisher()
    }
    
    private init() {}

    func addProblem(_ problem: Problem) {
        problemList.append(problem)
    }
}
