//
//  ProblemEditViewModel.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/27.
//

import Foundation
import Combine

final class ProblemEditViewModel {
    private let workbookManager = WorkbookManager.shared
    
    func addProblem(_ problem: Problem) {
        workbookManager.addProblem(problem)
    }
    
    func editProblem(with problem: Problem) {
        workbookManager.editProblem(with: problem)
    }
    
    func requestProblemListPublisher() -> AnyPublisher<[Problem], Never>? {
        return workbookManager.requestProblemListPublisher()
    }
}
