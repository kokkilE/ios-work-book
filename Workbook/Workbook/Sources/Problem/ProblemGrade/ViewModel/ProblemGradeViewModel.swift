//
//  ProblemGradeViewModel.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/30.
//

import Foundation
import Combine

final class ProblemGradeViewModel: UserAnswerProcessing {
    private let workbookManager = WorkbookManager.shared
    private let selectedWorkbook: Workbook?
    var userAnswerList: [ProblemUserAnswer]
    private(set) var correctProblemIndex = Set<Int>()
    var problemCount: Int? {
        get {
            selectedWorkbook?.getProblemsCount()
        }
    }
    var correctProblemCount: Int? {
        get {
            return correctProblemIndex.count
        }
    }
    
    init(_ viewModel: UserAnswerProcessing) {
        selectedWorkbook = workbookManager.selectedWorkbook()
        userAnswerList = viewModel.userAnswerList
        grade()
    }
    
    func requestProblemListPublisher() -> AnyPublisher<[Problem], Never>? {
        return workbookManager.requestProblemListPublisher()
    }
    
    func isCorrectAnswer(_ index: IndexPath) -> Bool {
        if correctProblemIndex.contains(index.item) {
            return true
        }
        
        return false
    }
    
    private func grade() {
        guard let selectedWorkbook else { return }
        
        let indexRange = userAnswerList.startIndex...userAnswerList.endIndex
        
        for index in indexRange {
            guard let userAnswer = userAnswerList[safe: index] else { continue }
            
            switch userAnswer.problemType {
            case .shortAnswer:
                if userAnswer.shortAnswer?.getExceptSpaces() == selectedWorkbook.getProblem(at: index)?.shortAnswer?.getExceptSpaces() {
                    correctProblemIndex.insert(index)
                }
            case .multipleChoice:
                if userAnswer.multipleAnswer == selectedWorkbook.getProblem(at: index)?.multipleAnswer {
                    correctProblemIndex.insert(index)
                }
            }
        }
    }
}
