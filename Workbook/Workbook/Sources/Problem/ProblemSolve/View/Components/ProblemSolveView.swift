//
//  ProblemSolveView.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/28.
//

import UIKit

final class ProblemSolveView: UIStackView {
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemGray6
        scrollView.layer.cornerRadius = 10
        
        return scrollView
    }()
    private lazy var mainStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       answerTextView,
                                                       problemExampleChoiceStackView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 4, bottom: 20, right: 4)
        stackView.isLayoutMarginsRelativeArrangement = true
        
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
        button.backgroundColor = .systemBlue
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
        button.backgroundColor = .systemBlue
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        layout()
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
        addArrangedSubview(scrollView)
        addArrangedSubview(buttonStackView)
        
        scrollView.addSubview(mainStackView)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.95),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
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
        
    }
    
    @objc private func touchUpNextButton() {
        
    }
}
