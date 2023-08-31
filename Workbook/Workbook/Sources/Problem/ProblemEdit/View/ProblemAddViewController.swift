//
//  ProblemAddViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/18.
//

import UIKit
import Combine

final class ProblemAddViewController: UIViewController {
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    private let problemAddView = ProblemAddView()
    private let viewModel = ProblemEditViewModel()
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
        view.backgroundColor = .systemGray6
    }
    
    private func addSubviews() {
        scrollView.addSubview(problemAddView)
        
        view.addSubview(scrollView)
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -8),
            
            problemAddView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            problemAddView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            problemAddView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            problemAddView.heightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.heightAnchor)
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
        leftBarButton.tintColor = AppColor.deepGreen
        
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    private func setupNavigationRightBarButtonItem() {
        let rightBarButton = UIButton()
        rightBarButton.addTarget(self, action: #selector(completeAddProblem), for: .touchUpInside)
        rightBarButton.setTitle("완료", for: .normal)
        rightBarButton.titleLabel?.font = .systemFont(ofSize: 20)
        rightBarButton.setTitleColor(AppColor.deepGreen, for: .normal)
        
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
        
        problemAddView.$newMultipleChoiceProblem
            .sink { [weak self] problem in
                guard let problem else { return }
                
                self?.presentProblemExampleChoiceViewController(problem)
            }
            .store(in: &subscriptions)
    }
    
    private func presentProblemExampleChoiceViewController(_ problem: Problem) {
        let viewController = ProblemExampleChoiceViewController(problem: problem, mode: .Add)
        
        present(viewController, animated: true)
    }
}
