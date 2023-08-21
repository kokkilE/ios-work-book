//
//  ErrorDescriptionProtocol.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/14.
//

import Foundation

protocol ErrorDescriptionProtocol: LocalizedError {
    var description: String { get }
}
