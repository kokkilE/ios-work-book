//
//  ProblemEditView.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/22.
//

import UIKit

final class ProblemEditView: UIStackView {
    private lazy var segmentedControl = {
        let segmentedControl = UISegmentedControl(items: [Problem.ProblemType.shortAnswer.description, Problem.ProblemType.multipleChoice.description])
        segmentedControl.selectedSegmentIndex = Problem.ProblemType.shortAnswer.index
        
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        segmentedControl.setTitleTextAttributes(attribute, for: .normal)
        
        segmentedControl.addTarget(self, action: #selector(configureWithSegmentedControl), for: .valueChanged)
        
        return segmentedControl
    }()
    
    private let problemTitleStackView = ProblemTitleStackView()
    private let problemExampleStackView = ProblemExampleStackView(isEditing: true)
    private let problemAnswerStackView = ProblemAnswerStackView()
    private let problemExplanationStackView = ProblemExplanationStackView()
    
    private let viewModel = ProblemViewModel()
    private var oldProblem: Problem
    var delegate: ViewControllerPresentable?
    
    init(problem: Problem) {
        oldProblem = problem
        
        super.init(frame: .zero)
        
        setupView()
        addSubviews()
        configure(with: problem)
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
        addArrangedSubview(problemExplanationStackView)
    }
    
    private func configure(with problem: Problem) {
        segmentedControl.selectedSegmentIndex = problem.problemType.index
        problemTitleStackView.configure(with: problem.question)
        problemAnswerStackView.configure(with: problem.shortAnswer)
        problemExampleStackView.configure(with: problem.example)
        problemExplanationStackView.configure(with: problem.explanation)
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
    
    func editProblem() throws {
        if segmentedControl.selectedSegmentIndex == Problem.ProblemType.shortAnswer.index {
            try editShortAnswerProblem()
            
            return
        }
        
        try editMultipleChoiceProblem()
    }
    
    private func editShortAnswerProblem() throws {
        guard problemTitleStackView.isCanComplete() else {
            throw ProblemError.emptyTitle
        }
                
        guard problemAnswerStackView.isCanComplete() else {
            throw ProblemError.emptyAnswer
        }
        
        let newProblem = createProblem()
        oldProblem.overwrite(with: newProblem)
        viewModel.editProblem(with: oldProblem)
    }
    
    private func editMultipleChoiceProblem() throws {
        guard problemTitleStackView.isCanComplete() else {
            throw ProblemError.emptyTitle
        }
        
        guard problemExampleStackView.isEnoughExamples() else {
            throw ProblemError.notEnoughExample
        }
        
        guard problemExampleStackView.isNoDuplication() else {
            throw ProblemError.duplicatedExample
        }
        
        let newProblem = createProblem()
        oldProblem.overwrite(with: newProblem)
        let problemExampleChoiceViewController = ProblemExampleChoiceViewController(problem: oldProblem, mode: .Edit)
        
        delegate?.presentViewController(problemExampleChoiceViewController)
    }
    
    private func createProblem() -> Problem {
        if segmentedControl.selectedSegmentIndex == Problem.ProblemType.shortAnswer.index {
            let problem = Problem(problemType: .shortAnswer,
                                  question: problemTitleStackView.getTitle(),
                                  example: nil,
                                  shortAnswer: problemAnswerStackView.getAnswer(),
                                  multipleAnswer: nil,
                                  explanation: problemExplanationStackView.getText())
            
            return problem
        }
        
        let problem = Problem(problemType: .multipleChoice,
                              question: problemTitleStackView.getTitle(),
                              example: problemExampleStackView.getExampleList(),
                              shortAnswer: nil,
                              multipleAnswer: nil,
                              explanation: problemExplanationStackView.getText())
        
        return problem
    }
}
