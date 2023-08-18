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
    
    var delegate: ProblemAddViewController?
    private var problem: Problem? {
        didSet {
            
        }
    }
    
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
    
    func addProblem() throws {
        if segmentedControl.selectedSegmentIndex == Problem.ProblemType.shortAnswer.index {
            try addShortAnswerProblem()
            
            return
        }
        
        try addMultipleChoiceProblem()
    }
    
    private func addShortAnswerProblem() throws {
        guard problemTitleStackView.isCanComplete() else {
            throw ProblemError.emptyTitle
        }
                
        guard problemAnswerStackView.isCanComplete() else {
            throw ProblemError.emptyAnswer
        }
        
        problem = createProblem()
    }
    
    private func addMultipleChoiceProblem() throws {
        guard problemTitleStackView.isCanComplete() else {
            throw ProblemError.emptyTitle
        }
        
        guard problemExampleStackView.isEnoughExamples() else {
            throw ProblemError.notEnoughExample
        }
        
        guard problemExampleStackView.isNoDuplication() else {
            throw ProblemError.duplicatedExample
        }
        
        let examples = problemExampleStackView.getExampleList()
        let problemExampleChoiceViewController = ProblemExampleChoiceViewController(examples: examples)
        
        delegate?.presentViewController(problemExampleChoiceViewController)
        
        problem = createProblem()
    }
    
    private func createProblem() -> Problem {
        if segmentedControl.selectedSegmentIndex == Problem.ProblemType.shortAnswer.index {
            let problem = Problem(problemType: .shortAnswer,
                                  question: problemTitleStackView.getTitle(),
                                  example: nil,
                                  shortAnswer: problemAnswerStackView.getAnswer(),
                                  multipleAnswer: nil)
            return problem
        }
        
        let problem = Problem(problemType: .shortAnswer,
                              question: problemTitleStackView.getTitle(),
                              example: problemExampleStackView.getExampleList(),
                              shortAnswer: nil,
                              multipleAnswer: nil)
        
        return problem
    }
}
