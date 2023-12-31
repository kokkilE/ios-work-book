//
//  ProblemSolveView.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/28.
//

import UIKit
import Combine

final class ProblemSolveView: UIStackView {
    private lazy var mainStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       answerTextView,
                                                       problemExampleChoiceStackView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.backgroundColor = AppColor.lightGreen
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = AppColor.deepGreen.cgColor
        stackView.layer.borderWidth = 0.5
        
        return stackView
    }()
    private let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()
    private let answerTextView = {
        let textView = ProblemTextView(placeHolder: "정답을 입력하세요.")
        
        return textView
    }()
    private var problemExampleChoiceStackView = {
        let view = ProblemExampleChoiceStackView(examples: nil)
        
        return view
    }()
    private lazy var buttonStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousButton, nextButton])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    private lazy var previousButton = {
        let button = UIButton()
        button.setTitle("이전", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = AppColor.deepGreen
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(touchUpPreviousButton), for: .touchUpInside)
        
        guard let titleLabel = button.titleLabel else { return button }
                
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -4)
        ])
        
        return button
    }()
    private lazy var nextButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = AppColor.deepGreen
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
        
        guard let titleLabel = button.titleLabel else { return button }
                
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -4)
        ])
        
        return button
    }()
    
    private var scrollViewHeightConstraint: NSLayoutConstraint?
    private let viewModel: ProblemSolveViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: ProblemSolveViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        setupView()
        addSubviews()
        bind()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        spacing = 20
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addArrangedSubview(buttonStackView)
        addArrangedSubview(mainStackView)
    }
    
    func configure(_ problem: Problem?) {
        guard let problem else { return }
        
        titleLabel.text = problem.question
        
        switch problem.problemType {
        case .shortAnswer:
            configureShortAnswerProblme()
        case .multipleChoice:
            configureMultipleAnswerProblme(problem)
        }
    }
    
    func configure(_ userAnswer: ProblemUserAnswer?) {
        guard let userAnswer else {
            answerTextView.restoreToPlaceHolder()
            
            return
        }
        
        switch userAnswer.problemType {
        case .shortAnswer:
            if let answer = userAnswer.shortAnswer {
                answerTextView.configure(answer)
            } else {
                answerTextView.restoreToPlaceHolder()
            }
        case .multipleChoice:
            problemExampleChoiceStackView.configureUserAnswer(userAnswer.multipleAnswer)
        }
    }
    
    private func configureShortAnswerProblme() {
        answerTextView.isHidden = false
        problemExampleChoiceStackView.isHidden = true
    }
    
    private func configureMultipleAnswerProblme(_ problem: Problem) {
        answerTextView.isHidden = true
        problemExampleChoiceStackView.isHidden = false
        
        let examples = problem.example
        
        problemExampleChoiceStackView.setupExampleLabelList(examples: examples)
    }
    
    @objc private func touchUpPreviousButton() {
        viewModel.saveUserAnswer(
            shortAnswer: answerTextView.isEmptyExceptSpaces() ? nil : answerTextView.text,
            multipleAnswer: problemExampleChoiceStackView.selectedIndexList
        )
        viewModel.moveToPrevious()
        
        if answerTextView.isFirstResponder {
            answerTextView.resignFirstResponder()
        }
    }
    
    @objc private func touchUpNextButton() {
        viewModel.saveUserAnswer(
            shortAnswer: answerTextView.isEmptyExceptSpaces() ? nil : answerTextView.text,
            multipleAnswer: problemExampleChoiceStackView.selectedIndexList
        )
        viewModel.moveToNext()
        
        if answerTextView.isFirstResponder {
            answerTextView.resignFirstResponder()
        }
    }
    
    private func bind() {
        viewModel.$currentProblem
            .sink { [weak self] _ in
                guard let self else { return }
                
                configureButtonState(isFirst: viewModel.isFirstProblem,
                                     isLast: viewModel.isLastProblem)
            }
            .store(in: &subscriptions)
    }
    
    private func configureButtonState(isFirst: Bool, isLast: Bool) {
        previousButton.isEnabled = true
        previousButton.alpha = 1
        nextButton.isEnabled = true
        nextButton.alpha = 1
        
        if isFirst {
            previousButton.isEnabled = false
            previousButton.alpha = 0.3
        }
        
        if isLast {
            nextButton.setTitle("제출", for: .normal)
        } else {
            nextButton.setTitle("다음", for: .normal)
        }
    }
}
