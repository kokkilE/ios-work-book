//
//  ProblemListViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import UIKit

final class ProblemListViewController: UIViewController {
    private let viewModel = WorkbookViewModel()
    private let problemControlView = ProblemControlView()
    
    init() {
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
        setupNavigationTitle()
        setupNavigationLeftBarButtonItem()
        setupNavigationRightBarButtonItem()
    }
    
    private func setupNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = viewModel.selectedWorkbookTitle
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let halfViewWidth = view.frame.width * 0.50
        titleLabel.widthAnchor.constraint(equalToConstant: halfViewWidth).isActive = true
        
        navigationItem.titleView = titleLabel
    }
    
    private func setupNavigationLeftBarButtonItem() {
        let systemImageName = "arrow.left"
        let backImage = UIImage(systemName: systemImageName)
        
        let leftBarButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(dismissProblemListViewController))
        leftBarButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    private func setupNavigationRightBarButtonItem() {
        let systemImageName = "plus"
        let addImage = UIImage(systemName: systemImageName)
        
        let rightBarButton = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(addProblem))
        rightBarButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func dismissProblemListViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addProblem() {
        let problemAddViewController = ProblemAddViewController()
        
        navigationController?.pushViewController(problemAddViewController, animated: true)
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
