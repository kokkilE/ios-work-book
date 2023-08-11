//
//  ProblemAddView.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/18.
//

import UIKit

final class ProblemAddView: UIStackView {
    private lazy var segmentedControl = {
        let segmentedControl = UISegmentedControl(items: [Problem.ProblemType.shortAnswer.description, Problem.ProblemType.multipleChoice.description])
        segmentedControl.selectedSegmentIndex = Problem.ProblemType.shortAnswer.index
        
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        segmentedControl.setTitleTextAttributes(attribute, for: .normal)
        
        segmentedControl.addTarget(self, action: #selector(configureWithSegmentedControl), for: .valueChanged)
        
        return segmentedControl
    }()
    
    private let problemTitleStackView = ProblemTitleStackView()
    private let problemExampleStackView = ProblemExampleStackView()
    private let problemAnswerStackView = ProblemAnswerStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        configureWithSegmentedControl()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 20
    }
    
    private func addSubviews() {
        addArrangedSubview(segmentedControl)
        addArrangedSubview(problemTitleStackView)
        addArrangedSubview(problemAnswerStackView)
        addArrangedSubview(problemExampleStackView)
    }
    
    @objc private func configureWithSegmentedControl() {
        if segmentedControl.selectedSegmentIndex == Problem.ProblemType.shortAnswer.index {
            problemAnswerStackView.isHidden = false
            problemExampleStackView.isHidden = true
        } else if segmentedControl.selectedSegmentIndex == Problem.ProblemType.multipleChoice.index {
            problemAnswerStackView.isHidden = true
            problemExampleStackView.isHidden = false
        }
    }
    
    func addProblem() throws -> Problem? {
        if segmentedControl.selectedSegmentIndex == Problem.ProblemType.shortAnswer.index {
            return try addShortAnswerProblem()
        } else if segmentedControl.selectedSegmentIndex == Problem.ProblemType.multipleChoice.index {
            return try addMultipleChoiceProblem()
        }
        
        return nil
    }
    
    private func addShortAnswerProblem() throws -> Problem {
        guard problemTitleStackView.isCanComplete() else {
            throw ProblemError.emptyTitle
        }
                
        guard problemAnswerStackView.isCanComplete() else {
            throw ProblemError.emptyAnswer
        }
        
        let problem = Problem(problemType: .shortAnswer,
                              question: problemTitleStackView.getTitle(),
                              example: nil,
                              answer: problemAnswerStackView.getAnswer())
        
        return problem
    }
    
    private func addMultipleChoiceProblem() throws -> Problem {
        guard problemTitleStackView.isCanComplete() else {
            throw ProblemError.emptyTitle
        }
                
        guard problemExampleStackView.isCanComplete() else {
            throw ProblemError.notEnoughExample
        }
        
        let problemExampleChoiceStackView = ProblemExampleChoiceStackView(examples: problemExampleStackView.getExampleList())
        
        addArrangedSubview(problemExampleChoiceStackView)
        
        let problem = Problem(problemType: .shortAnswer,
                              question: problemTitleStackView.getTitle(),
                              example: problemExampleStackView.getExampleList(),
                              answer: problemAnswerStackView.getAnswer())
        
        return problem
    }
}
