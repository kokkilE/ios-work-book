//
//  WorkbookViewModel.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import Foundation
import Combine

final class WorkbookViewModel {
    private var workbookManager = WorkbookManager.shared
    
    var selectedWorkbookTitle: String? {
        return workbookManager.selectedWoorbookTitle()
    }
    
    func requestWorkbookListPublisher() -> AnyPublisher<[Workbook], Never> {
        return workbookManager.requestWorkbookListPublisher()
    }
    
    func addWorkbook(_ title: String) {
        let workbook = Workbook(title: title, problems: [])
        
        workbookManager.addWorkbook(workbook)
    }
    
    func selectWorkbook(at indexPath: IndexPath) throws {
        do {
            try workbookManager.selectWorkbook(at: indexPath.item)
        } catch {
            throw WorkbookError.wrongSubscript
        }
    }
}
