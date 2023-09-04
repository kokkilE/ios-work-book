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
    private lazy var progressLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let halfViewWidth = view.frame.width * 0.50
        label.widthAnchor.constraint(equalToConstant: halfViewWidth).isActive = true
        
        return label
    }()
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    private lazy var problemSolveView = ProblemSolveView(viewModel: viewModel)
    
    private var subscriptions = Set<AnyCancellable>()
    private var dynamicScrollViewBottomAnchor: NSLayoutConstraint?
    
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
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        scrollView.addSubview(problemSolveView)
        
        view.addSubview(scrollView)
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        
        configureScrollViewBottomAnchor(constant: -8)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            
            problemSolveView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            problemSolveView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            problemSolveView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            problemSolveView.heightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.heightAnchor)
        ])
    }
    
    private func setupNavigationItems() {
        setupNavigationLeftBarButtonItem()
        setupNavigationTitle()
    }
    
    private func setupNavigationLeftBarButtonItem() {
        let systemImageName = "arrow.left"
        let backImage = UIImage(systemName: systemImageName)
        
        let leftBarButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(dismissProblemSolveViewController))
        leftBarButton.tintColor = AppColor.deepGreen
        
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    private func setupNavigationTitle() {
        navigationItem.titleView = progressLabel
    }
    
    private func bind() {
        viewModel.$currentProblem
            .sink { [weak self] problem in
                guard let self else { return }
                
                var animationOption: UIView.AnimationOptions
                if viewModel.isMovedToNext {
                    animationOption = .transitionCurlUp
                } else {
                    animationOption = .transitionCurlDown
                }
                
                UIView.transition(with: view, duration: 0.5, options: animationOption, animations: {
                    DispatchQueue.main.async {
                        self.progressLabel.text = self.viewModel.getProgressString()
                        self.problemSolveView.configure(problem)
                        self.problemSolveView.configure(self.viewModel.currentProblemUserAnswer)
                    }
                }, completion: nil)
            }
            .store(in: &subscriptions)
        
        viewModel.$isAnswerSubmitted
            .sink { [weak self] isAnswerSubmitted in
                guard let self,
                      isAnswerSubmitted else { return }
                
                let problemGradeViewController = ProblemGradeViewController(viewModel: viewModel)
                
                navigationController?.pushViewController(problemGradeViewController, animated: true)
            }
            .store(in: &subscriptions)
    }
    
    @objc private func dismissProblemSolveViewController() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: Keyboard layout
extension ProblemSolveViewController {
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
