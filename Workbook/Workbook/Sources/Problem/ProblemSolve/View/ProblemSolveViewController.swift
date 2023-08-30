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
    private lazy var problemSolveView = ProblemSolveView(viewModel: viewModel)
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        layout()
        setupNavigationItems()
        bind()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(problemSolveView)
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            problemSolveView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            problemSolveView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            problemSolveView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16)
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
                    self.progressLabel.text = self.viewModel.getProgressString()
                    self.problemSolveView.configure(problem)
                    self.problemSolveView.configure(self.viewModel.currentProblemUserAnswer)
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
