//
//  ProblemListViewModel.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/19.
//

import Foundation
import Combine

final class ProblemListViewModel {
    private let workbookManager = WorkbookManager.shared
    
    func requestProblemListPublisher() -> AnyPublisher<[Problem], Never>? {
        return workbookManager.requestProblemListPublisher()
    }
    
    func getProblem(at index: Int) -> Problem? {
        return workbookManager.getProblem(at: index)
    }
    
    func getWorkbookTitle() -> String? {
        return workbookManager.selectedWoorbookTitle()
    }
    
    func deleteProblem(at index: Int) {
        workbookManager.deleteProblem(at: index)
    }
}
