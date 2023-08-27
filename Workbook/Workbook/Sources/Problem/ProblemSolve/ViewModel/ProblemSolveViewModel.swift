//
//  ProblemSolveViewModel.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/27.
//

import Foundation
import Combine

final class ProblemSolveViewModel {
    private let workbookManager = WorkbookManager.shared
    private let selectedWorkbook: Workbook?
    private var currentProblemIndex = 0
    private let problemsCount: Int?
    @Published var currentProblem: Problem?
    
    init() {
        selectedWorkbook = workbookManager.selectedWorkbook()
        problemsCount = selectedWorkbook?.getProblemsCount()
    }
    
    func getProgressString() -> String? {
        guard let problemsCount else { return nil }
        
        return "\(currentProblemIndex + 1) / \(problemsCount)"
    }
}
