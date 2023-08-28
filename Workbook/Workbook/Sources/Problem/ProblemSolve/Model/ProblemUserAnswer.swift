//
//  ProblemUserAnswer.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/28.
//

import Foundation

struct ProblemUserAnswer {
    var problemType: Problem.ProblemType
    var shortAnswer: String?
    var multipleAnswer: Set<Int>?
}
