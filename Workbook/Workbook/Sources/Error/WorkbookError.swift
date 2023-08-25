//
//  WorkbookError.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import Foundation

enum WorkbookError: ErrorDescriptionProtocol {
    case emptyTitle
    case wrongSubscript
    
    var description: String {
        switch self {
        case .emptyTitle:
            return "문제집의 이름은 공백일 수 없습니다."
        case .wrongSubscript:
            return "wrong subscript"
        }
    }
}
