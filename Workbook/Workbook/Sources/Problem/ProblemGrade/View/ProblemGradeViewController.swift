//
//  ProblemGradeViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/30.
//

import UIKit

class ProblemGradeViewController: UIViewController {
    private let resultControlView = ResultControlView()
    private let viewModel: ProblemGradeViewModel
    
    init(viewModel: UserAnswerProcessing) {
        self.viewModel = ProblemGradeViewModel(viewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        layout()
        
        resultControlView.configureOverviewLabel(
            problemCount: viewModel.problemCount,
            correctProblemCount: viewModel.correctProblemCount
        )
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
    }
    
    private func addSubviews() {
        view.addSubview(resultControlView)
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            resultControlView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 4),
            resultControlView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 8),
            resultControlView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -8)
        ])
    }
}
