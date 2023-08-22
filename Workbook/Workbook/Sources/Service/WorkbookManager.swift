//
//  WorkbookManager.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/19.
//

import Foundation
import Combine

final class WorkbookManager {
    static let shared = WorkbookManager()
    
    @Published private var workbookList = [Workbook]()
    
    private var selectedWorkbookIndex: Int?
    
    private init() {}
    
    func requestWorkbookListPublisher() -> AnyPublisher<[Workbook], Never> {
        return $workbookList.eraseToAnyPublisher()
    }
    
    func requestProblemListPublisher() -> AnyPublisher<[Problem], Never>? {
        guard let selectedWorkbookIndex else { return nil }
        
        return workbookList[safe: selectedWorkbookIndex]?
            .requestProblemsPublisher()
            .eraseToAnyPublisher()
    }
    
    func addWorkbook(_ workbook: Workbook) {
        workbookList.append(workbook)
    }
    
    func selectWorkbook(at index: Int) throws {
        guard workbookList[safe: index] != nil else {
            throw WorkbookError.wrongSubscript
        }
        
        selectedWorkbookIndex = index
    }
    
    func selectedWoorbookTitle() -> String? {
        guard let selectedWorkbookIndex else { return nil }
        
        return workbookList[safe: selectedWorkbookIndex]?.getTitle()
    }
    
    func addProblem(_ problem: Problem) {
        guard let selectedWorkbookIndex else { return }
        
        workbookList[safe: selectedWorkbookIndex]?.addProblem(problem)
    }
    
    func getProblem(at index: Int) -> Problem? {
        guard let selectedWorkbookIndex else { return nil }
        
        return workbookList[safe: selectedWorkbookIndex]?
            .getProblem(at: index)
    }
}
