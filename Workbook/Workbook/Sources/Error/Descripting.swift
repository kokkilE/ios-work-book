//
//  Descripting.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/14.
//

import Foundation

protocol Descripting: LocalizedError {
    var description: String { get }
}
