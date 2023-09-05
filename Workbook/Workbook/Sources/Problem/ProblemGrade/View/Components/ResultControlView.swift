//
//  ResultControlView.swift
//  Workbook
//
//  Created by 조향래 on 2023/09/04.
//

import UIKit

final class ResultControlView: UIStackView {
    private let overviewLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    private lazy var buttonStackView = {
        let stackView = UIStackView(arrangedSubviews: [explainWrongProblemButton,
                                                       explainAllProblemButton])
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = 8
        
        return stackView
    }()
    private lazy var explainWrongProblemButton = {
        let button = UIButton()
        button.setTitle("틀린 문제 해설", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = AppColor.deepGreen
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(explainWrongProblem), for: .touchUpInside)
        
        guard let titleLabel = button.titleLabel else { return button }
                
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -4)
        ])
        
        return button
    }()
    private lazy var explainAllProblemButton = {
        let button = UIButton()
        button.setTitle("전체 문제 해설", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = AppColor.deepGreen
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(explainAllProblem), for: .touchUpInside)
        
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
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureOverviewLabel(problemCount: Int?, correctProblemCount: Int?) {
        guard let problemCount,
              let correctProblemCount else { return }
        
        let formattedCorrectAnswersPercentage = NumberFormatter().getPercent(
            numerator: correctProblemCount,
            denominator: problemCount,
            digits: 2
        )
        
        overviewLabel.text = "정답률: \(formattedCorrectAnswersPercentage)% (\(correctProblemCount) / \(problemCount))"
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        alignment = .top
        
        layoutMargins = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        isLayoutMarginsRelativeArrangement = true
    }
    
    private func addSubviews() {
        addArrangedSubview(overviewLabel)
        addArrangedSubview(buttonStackView)
    }
    
    @objc private func explainWrongProblem() {
        
    }
    
    @objc private func explainAllProblem() {
        
    }
}

