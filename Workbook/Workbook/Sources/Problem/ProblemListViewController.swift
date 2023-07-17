//
//  ProblemListViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import UIKit

final class ProblemListViewController: UIViewController {
    private let viewModel: WorkbookViewModel
    private let problemControlView = ProblemControlView()
    
    init(viewModel: WorkbookViewModel) {
        self.viewModel = viewModel
        
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
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(problemControlView)
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            problemControlView.topAnchor.constraint(equalTo: safe.topAnchor),
            problemControlView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            problemControlView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            problemControlView.heightAnchor.constraint(equalTo: safe.heightAnchor, multiplier: 0.10)
        ])
    }
}
