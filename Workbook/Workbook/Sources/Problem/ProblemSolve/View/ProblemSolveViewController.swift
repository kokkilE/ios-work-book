//
//  ProblemSolveViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/25.
//

import UIKit
import Combine

class ProblemSolveViewController: UIViewController {
    private let viewModel = ProblemSolveViewModel()
    private let progressLabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationItems()
        bind()
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
    
    private func bind() {
        viewModel.$currentProblem
            .sink { [weak self] _ in
                self?.progressLabel.text = self?.viewModel.getProgressString()
            }
            .store(in: &subscriptions)
    }
}
