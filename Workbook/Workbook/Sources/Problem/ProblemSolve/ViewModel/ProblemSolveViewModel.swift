//
//  ProblemSolveViewModel.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/27.
//

import Foundation
import Combine

final class ProblemSolveViewModel: UserAnswerProcessing {
    private let workbookManager = WorkbookManager.shared
    private let selectedWorkbook: Workbook?
    var userAnswerList = [ProblemUserAnswer]()
    private var currentProblemIndex = 0
    private let problemsCount: Int?
    @Published var currentProblem: Problem?
    var currentProblemUserAnswer: ProblemUserAnswer? {
        get {
            return userAnswerList[safe: currentProblemIndex]
        }
    }
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
    private(set) var isMovedToNext = true
    @Published var isAnswerSubmitted = false
    
    init() {
        selectedWorkbook = workbookManager.selectedWorkbook()
        problemsCount = selectedWorkbook?.getProblemsCount()
        currentProblem = workbookManager.getProblem(at: currentProblemIndex)
    }
    
    func moveToPrevious() {
        guard let problemsCount,
              0...(problemsCount - 1) ~= (currentProblemIndex - 1) else { return }
        
        isMovedToNext = false
        currentProblemIndex -= 1
        currentProblem = workbookManager.getProblem(at: currentProblemIndex)
    }
    
    func moveToNext() {
        guard let problemsCount,
              0...(problemsCount - 1) ~= (currentProblemIndex + 1) else {
            isAnswerSubmitted = true
            
            return
        }
        
        isMovedToNext = true
        currentProblemIndex += 1
        currentProblem = workbookManager.getProblem(at: currentProblemIndex)
    }
    
    func getProgressString() -> String? {
        guard let problemsCount else { return nil }
        
        return "\(currentProblemIndex + 1) / \(problemsCount)"
    }
    
    func saveUserAnswer(shortAnswer: String?, multipleAnswer: Set<Int>?) {
        guard let problemType = currentProblem?.problemType else { return }
        
        switch problemType {
        case .shortAnswer:
            if userAnswerList[safe: currentProblemIndex] == nil {
                let problemUserAnswer = ProblemUserAnswer(problemType: problemType,
                                                          shortAnswer: shortAnswer,
                                                          multipleAnswer: nil)
                userAnswerList.append(problemUserAnswer)
                
                return
            }
            
            userAnswerList[safe: currentProblemIndex]?.shortAnswer = shortAnswer
        case .multipleChoice:
            if userAnswerList[safe: currentProblemIndex] == nil {
                let problemUserAnswer = ProblemUserAnswer(problemType: problemType,
                                                          shortAnswer: nil,
                                                          multipleAnswer: multipleAnswer)
                userAnswerList.append(problemUserAnswer)
                
                return
            }
            
            userAnswerList[safe: currentProblemIndex]?.multipleAnswer = multipleAnswer
        }
    }
}
