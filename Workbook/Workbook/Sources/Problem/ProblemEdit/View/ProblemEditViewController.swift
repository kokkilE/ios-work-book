//
//  ProblemEditViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/22.
//

import UIKit
import Combine

final class ProblemEditViewController: UIViewController {
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    private let problemEditView: ProblemEditView
    private let viewModel = ProblemEditViewModel()
    private var subscriptions = Set<AnyCancellable>()
    private var dynamicScrollViewBottomAnchor: NSLayoutConstraint?
    
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
        addKeyboardObserver()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
    }
    
    private func addSubviews() {
        scrollView.addSubview(problemEditView)
        
        view.addSubview(scrollView)
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        
        configureScrollViewBottomAnchor(constant: -8)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            
            problemEditView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            problemEditView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            problemEditView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            problemEditView.heightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.heightAnchor)
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
        leftBarButton.tintColor = AppColor.deepGreen
        
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    private func setupNavigationRightBarButtonItem() {
        let rightBarButton = UIButton()
        rightBarButton.addTarget(self, action: #selector(completeEditProblem), for: .touchUpInside)
        rightBarButton.setTitle("완료", for: .normal)
        rightBarButton.titleLabel?.font = .systemFont(ofSize: 20)
        rightBarButton.setTitleColor(AppColor.deepGreen, for: .normal)
        
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
        
        problemEditView.$newMultipleChoiceProblem
            .sink { [weak self] problem in
                guard let problem else { return }
                
                self?.presentProblemExampleChoiceViewController(problem)
            }
            .store(in: &subscriptions)
    }
    
    private func presentProblemExampleChoiceViewController(_ problem: Problem) {
        let viewController = ProblemExampleChoiceViewController(problem: problem, mode: .Edit)
        
        present(viewController, animated: true)
    }
}

// MARK: Keyboard layout
extension ProblemEditViewController {
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            configureScrollViewBottomAnchor(constant: -keyboardFrame.height)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        configureScrollViewBottomAnchor(constant: -8)
    }
    
    private func configureScrollViewBottomAnchor(constant: CGFloat) {
        dynamicScrollViewBottomAnchor?.isActive = false
        
        dynamicScrollViewBottomAnchor = scrollView.frameLayoutGuide.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: constant
        )
        
        dynamicScrollViewBottomAnchor?.isActive = true
    }
}
