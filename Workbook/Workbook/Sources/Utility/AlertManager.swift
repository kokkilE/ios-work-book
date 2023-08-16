//
//  AlertManager.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import UIKit

struct AlertManager {
    func createNewFolderAlert(okCompletion: @escaping (String) -> ()) -> UIAlertController {
        let alertController = UIAlertController(title: "새 문제집을 만들어요.", message: nil, preferredStyle: .alert)
        
        alertController.addTextField() { textField in
            textField.placeholder = "문제집 이름"
        }
        
        let confirmAction = UIAlertAction(title: "생성", style: .default) { _ in
            if let textFields = alertController.textFields,
               let textField = textFields.first,
               let text = textField.text {
                okCompletion(text)
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive)
                
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    func createErrorAlert(error: Error) -> UIAlertController {
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        
        if let descriptingError = error as? Descripting {
            alertController.message = descriptingError.description
        } else {
            alertController.message = error.localizedDescription
        }
        
        let confirmAction = UIAlertAction(title: "확인", style: .cancel)
        
        alertController.addAction(confirmAction)
        
        return alertController
    }
}
