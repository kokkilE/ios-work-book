//
//  ProblemGradeViewModel.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/30.
//

import Foundation

final class ProblemGradeViewModel: UserAnswerProcessing {
    
    var selectedWorkbook: Workbook?
    var userAnswerList: [ProblemUserAnswer]
    private var wrongProblemIndex = Set<Int>()
    var selectedWorkbookCount: Int? {
        get {
            selectedWorkbook?.getProblemsCount()
        }
    }
    var correctProblemCount: Int? {
        get {
            guard let selectedWorkbookCount else { return nil }
            
            return selectedWorkbookCount - wrongProblemIndex.count
        }
    }
    
    init(_ viewModel: UserAnswerProcessing) {
        selectedWorkbook = viewModel.selectedWorkbook
        userAnswerList = viewModel.userAnswerList
        grade()
    }
    
    private func grade() {
        guard let selectedWorkbook else { return }
        
        let indexRange = userAnswerList.startIndex...userAnswerList.endIndex
        
        for index in indexRange {
            guard let userAnswer = userAnswerList[safe: index] else { continue }
            
            switch userAnswer.problemType {
            case .shortAnswer:
                if userAnswer.shortAnswer?.getExceptSpaces() == selectedWorkbook.getProblem(at: index)?.shortAnswer?.getExceptSpaces() {
                    wrongProblemIndex.insert(index)
                }
            case .multipleChoice:
                if userAnswer.multipleAnswer == selectedWorkbook.getProblem(at: index)?.multipleAnswer {
                    wrongProblemIndex.insert(index)
                }
            }
        }
    }
}
