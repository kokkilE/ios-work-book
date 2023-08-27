//
//  ProblemSolveViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/25.
//

import UIKit

class ProblemSolveViewController: UIViewController {
//    private let viewModel = ProblemViewModel()
    private let progressLabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationItems()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupNavigationItems() {
        setupNavigationTitle()
    }
    
    private func setupNavigationTitle() {
        navigationItem.titleView = progressLabel
    }
}
