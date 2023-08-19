//
//  ProblemError.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/09.
//

import Foundation

enum ProblemError: ErrorDescriptionProtocol {
    case emptyTitle
    case emptyAnswer
    case notEnoughExample
    case duplicatedExample
    
    var description: String {
        switch self {
        case .emptyTitle:
            return "문항의 제목을 작성해주세요."
        case .emptyAnswer:
            return "문항의 정답을 작성해주세요."
        case .notEnoughExample:
            return "문항의 보기를 \(Problem.minimumExampleCount)개 이상 작성해주세요."
        case .duplicatedExample:
            return "문항의 보기가 중복되었습니다."
        }
    }
}
