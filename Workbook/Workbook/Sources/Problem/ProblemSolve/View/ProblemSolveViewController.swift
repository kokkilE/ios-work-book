//
//  ProblemSolveViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/25.
//

import UIKit
import Combine

final class ProblemSolveViewController: UIViewController {
    private let viewModel = ProblemSolveViewModel()
    private let progressLabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    private let problemSolveView = ProblemSolveView()
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        layout()
        setupNavigationItems()
        bind()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(problemSolveView)
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            problemSolveView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            problemSolveView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            problemSolveView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            problemSolveView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupNavigationItems() {
        setupNavigationTitle()
    }
    
    private func setupNavigationTitle() {
        navigationItem.titleView = progressLabel
    }
    
    private func bind() {
        viewModel.$currentProblem
            .sink { [weak self] problem in                
                self?.progressLabel.text = self?.viewModel.getProgressString()
                self?.problemSolveView.configure(problem)
            }
            .store(in: &subscriptions)
    }
}
