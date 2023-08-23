//
//  ProblemEditViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/22.
//

import UIKit
import Combine

final class ProblemEditViewController: UIViewController {
    private let problemEditView: ProblemEditView
    private let viewModel = ProblemViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    init(problem: Problem) {
        problemEditView = ProblemEditView(problem: problem)
        
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
        setupNavigationItems()
        bind()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(problemEditView)
        
        problemEditView.delegate = self
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            problemEditView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
            problemEditView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            problemEditView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupNavigationItems() {
        setupNavigationLeftBarButtonItem()
        setupNavigationRightBarButtonItem()
    }
    
    private func setupNavigationLeftBarButtonItem() {
        let systemImageName = "arrow.left"
        let backImage = UIImage(systemName: systemImageName)
        
        let leftBarButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(dismissProblemEditViewController))
        leftBarButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    private func setupNavigationRightBarButtonItem() {
        let rightBarButton = UIButton()
        rightBarButton.addTarget(self, action: #selector(completeEditProblem), for: .touchUpInside)
        rightBarButton.setTitle("완료", for: .normal)
        rightBarButton.titleLabel?.font = .systemFont(ofSize: 20)
        rightBarButton.setTitleColor(.black, for: .normal)
        rightBarButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    }
    
    @objc private func dismissProblemEditViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func completeEditProblem() {
        do {
            try problemEditView.editProblem()
        } catch {
            let alert = AlertManager().createErrorAlert(error: error)
            
            present(alert, animated: true)
        }
    }
    
    private func bind() {
        viewModel.requestProblemListPublisher()?
            .dropFirst()
            .sink { [weak self] _ in
                    self?.dismissProblemEditViewController()
            }
            .store(in: &subscriptions)
    }
}

extension ProblemEditViewController: ViewControllerPresentable {
    func presentViewController(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
}
