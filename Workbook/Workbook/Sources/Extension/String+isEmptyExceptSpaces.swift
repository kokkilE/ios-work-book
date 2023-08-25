//
//  String+isEmptyExceptSpaces.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/25.
//

import Foundation

extension String {
    func isEmptyExceptSpaces() -> Bool {
        var copiedText = self
        
        copiedText.removeAll { $0 == " " || $0 == "\n" }
        
        if copiedText.isEmpty {
            return true
        }
        
        return false
    }
}
