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
    
    init(_ viewModel: UserAnswerProcessing) {
        selectedWorkbook = viewModel.selectedWorkbook
        userAnswerList = viewModel.userAnswerList
    }
}
