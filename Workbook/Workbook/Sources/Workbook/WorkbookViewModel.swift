//
//  WorkbookViewModel.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import Foundation
import Combine

final class WorkbookViewModel {
    @Published var workbookList = [Workbook]()
    var selectedWorkbook: Workbook?
    
    func createWorkbook(_ title: String) {
        let workbook = Workbook(title: title, problems: [])
        
        workbookList.append(workbook)
    }
    
    func selectWorkbook(at indexPath: IndexPath) throws {
        guard let workbook = workbookList[safe: indexPath.item] else {
            throw WorkbookError.wrongSubscript
        }
        
        selectedWorkbook = workbook
    }
}
