//
//  ProblemSolveView.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/28.
//

import UIKit

final class ProblemSolveView: UIStackView {
    private let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        axis = .vertical
        spacing = 20
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(answerTextView)
        addArrangedSubview(problemExampleChoiceStackView)
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
}
