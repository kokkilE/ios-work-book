//
//  ProblemViewModel.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/19.
//

import Foundation
import Combine

final class ProblemViewModel {
    private let problemManager = ProblemManager.shared
    @Published var isProblemAdded = false
    
    func addProblem(_ problem: Problem) {
        problemManager.addProblem(problem)
        isProblemAdded = true
    }
    
    func requestProblemListPublisher() -> AnyPublisher<[Problem], Never> {
        return problemManager.requestProblemListPublisher()
    }
}
