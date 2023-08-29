//
//  ProblemControlView.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import UIKit

final class ProblemControlView: UIStackView {
    private let problemCountLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    private lazy var solveProblemButton = {
        let button = UIButton()
        button.setTitle("문제 풀기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = AppColor.deepGreen
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(solveProblem), for: .touchUpInside)
        
        guard let titleLabel = button.titleLabel else { return button }
                
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -4)
        ])
        
        return button
    }()
    
    @Published var isSolveButtonTapped = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureProblemCountLabel(_ problemCount: Int) {
        problemCountLabel.text = "문항 수: \(problemCount)"
        toggleButtonActiveState(problemCount)
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        
        layoutMargins = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        isLayoutMarginsRelativeArrangement = true
    }
    
    private func addSubviews() {
        addArrangedSubview(problemCountLabel)
        addArrangedSubview(solveProblemButton)
    }
    
    private func toggleButtonActiveState(_ problemCount: Int) {
        if problemCount == 0 {
            solveProblemButton.isEnabled = false
            solveProblemButton.alpha = 0.3
            
            return
        }
        
        solveProblemButton.isEnabled = true
        solveProblemButton.alpha = 1
    }
    
    @objc private func solveProblem() {
        isSolveButtonTapped = true
    }
}
