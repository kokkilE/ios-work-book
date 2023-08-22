//
//  ProblemViewModel.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/19.
//

import Foundation
import Combine

final class ProblemViewModel {
    private let workbookManager = WorkbookManager.shared
    @Published var isProblemAdded = false
    var workbookTitle: String? {
        return workbookManager.selectedWoorbookTitle()
    }
    
    func addProblem(_ problem: Problem) {
        workbookManager.addProblem(problem)
        isProblemAdded = true
    }
    
    func requestWorkbookListPublisher() -> AnyPublisher<[Workbook], Never> {
        return workbookManager.requestWorkbookListPublisher()
    }
    
    func requestProblemListPublisher() -> AnyPublisher<[Problem], Never>? {
        return workbookManager.requestProblemListPublisher()
    }
    
    func getProblem(at index: Int) -> Problem? {
        return workbookManager.getProblem(at: index)
    }
}
