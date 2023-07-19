//
//  ProblemControlView.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import UIKit

final class ProblemControlView: UIStackView {
    private let solveProblemButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let addProblemButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray
        
    }
    
    private func addSubviews() {
        addArrangedSubview(solveProblemButton)
        addArrangedSubview(addProblemButton)
    }
}
