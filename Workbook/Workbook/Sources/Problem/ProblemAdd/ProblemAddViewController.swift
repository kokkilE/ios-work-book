//
//  ProblemAddViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/18.
//

import UIKit

final class ProblemAddViewController: UIViewController {
    private let problemAddView = ProblemAddView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        layout()
        setupNavigationItems()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(problemAddView)
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            problemAddView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
            problemAddView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            problemAddView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupNavigationItems() {
        setupNavigationLeftBarButtonItem()
        setupNavigationRightBarButtonItem()
    }
    
    private func setupNavigationLeftBarButtonItem() {
        let systemImageName = "arrow.left"
        let backImage = UIImage(systemName: systemImageName)
        
        let leftBarButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(dismissProblemAddViewController))
        leftBarButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    private func setupNavigationRightBarButtonItem() {
        let rightBarButton = UIButton()
//        rightBarButton.addTarget(self, action: #selector(addProblem), for: .touchUpInside)
        rightBarButton.setTitle("사진으로 추가", for: .normal)
        rightBarButton.titleLabel?.font = .systemFont(ofSize: 20)
        rightBarButton.setTitleColor(.black, for: .normal)
        rightBarButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    }
    
    @objc private func dismissProblemAddViewController() {
        navigationController?.popViewController(animated: true)
    }
}
