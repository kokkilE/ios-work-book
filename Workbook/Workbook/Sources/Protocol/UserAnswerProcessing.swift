//
//  UserAnswerProcessing.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/30.
//

import Foundation

protocol UserAnswerProcessing {
    var selectedWorkbook: Workbook? { get }
    var userAnswerList: [ProblemUserAnswer] { get }
}
