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
        setupNavigationItems()
        addSubviews()
        layout()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationItems() {
        setupNavigationLeftBarButtonItem()
        setupNavigationRightBarButtonItem()
    }
    
    private func setupNavigationLeftBarButtonItem() {
        let systemImageName = "chevron.backward"
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let backImage = UIImage(systemName: systemImageName, withConfiguration: imageConfiguration)
        
        let leftBarButton = UIButton()
        leftBarButton.addTarget(self, action: #selector(dismissProblemList),
                                for: .touchUpInside)
        leftBarButton.setImage(backImage, for: .normal)
        leftBarButton.setTitle(viewModel.selectedWorkbookTitle, for: .normal)
        leftBarButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        leftBarButton.setTitleColor(.black, for: .normal)
        leftBarButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
    }
    
    private func setupNavigationRightBarButtonItem() {
        let systemImageName = "plus.app"
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let addImage = UIImage(systemName: systemImageName, withConfiguration: imageConfiguration)
        
        let rightBarButton = UIButton()
        rightBarButton.addTarget(self, action: #selector(addProblem), for: .touchUpInside)
        rightBarButton.setImage(addImage, for: .normal)
        rightBarButton.setTitle("문제 추가", for: .normal)
        rightBarButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        rightBarButton.setTitleColor(.black, for: .normal)
        rightBarButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    }
    
    @objc private func dismissProblemList() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addProblem() {
        
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
