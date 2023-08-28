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
    var isFirstProblem: Bool {
        get {
            return currentProblemIndex == 0
        }
    }
    var isLastProblem: Bool {
        get {
            guard let problemsCount else { return false }
            
            return currentProblemIndex == problemsCount - 1
        }
    }
    
    init() {
        selectedWorkbook = workbookManager.selectedWorkbook()
        problemsCount = selectedWorkbook?.getProblemsCount()
        currentProblem = selectedWorkbook?.getProblem(at: currentProblemIndex)
    }
    
    func moveToPrevious() {
        guard let problemsCount,
              0...(problemsCount - 1) ~= (currentProblemIndex - 1) else { return }
        
        currentProblemIndex -= 1
        currentProblem = selectedWorkbook?.getProblem(at: currentProblemIndex)
    }
    
    func moveToNext() {
        guard let problemsCount,
              0...(problemsCount - 1) ~= (currentProblemIndex + 1) else { return }
        
        currentProblemIndex += 1
        currentProblem = selectedWorkbook?.getProblem(at: currentProblemIndex)
    }
    
    func getProgressString() -> String? {
        guard let problemsCount else { return nil }
        
        return "\(currentProblemIndex + 1) / \(problemsCount)"
    }
}
