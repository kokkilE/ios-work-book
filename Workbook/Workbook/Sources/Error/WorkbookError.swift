//
//  WorkbookError.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import Foundation

enum WorkbookError: Descripting {
    case wrongSubscript
    
    var description: String {
        switch self {
        case .wrongSubscript:
            return "wrong subscript"
        }
    }
}
