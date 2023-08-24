//
//  ProblemAddViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/18.
//

import UIKit
import Combine

final class ProblemAddViewController: UIViewController {
    private let problemAddView = ProblemAddView()
    private let viewModel = ProblemViewModel()
    private var subscriptions = Set<AnyCancellable>()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        layout()
        setupNavigationItems()
        bind()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(problemAddView)
        
        problemAddView.delegate = self
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
        rightBarButton.addTarget(self, action: #selector(completeAddProblem), for: .touchUpInside)
        rightBarButton.setTitle("완료", for: .normal)
        rightBarButton.titleLabel?.font = .systemFont(ofSize: 20)
        rightBarButton.setTitleColor(.systemBlue, for: .normal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    }
    
    @objc private func dismissProblemAddViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func completeAddProblem() {
        do {
            try problemAddView.addProblem()
        } catch {
            let alert = AlertManager().createErrorAlert(error: error)
            
            present(alert, animated: true)
        }
    }
    
    private func bind() {
        viewModel.requestProblemListPublisher()?
            .dropFirst()
            .sink { [weak self] _ in
                    self?.dismissProblemAddViewController()
            }
            .store(in: &subscriptions)
    }
}

extension ProblemAddViewController: ViewControllerPresentable {
    func presentViewController(_ viewController: UIViewController) {        
        present(viewController, animated: true)
    }
}
