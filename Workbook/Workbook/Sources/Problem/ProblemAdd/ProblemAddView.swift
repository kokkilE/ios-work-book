//
//  ProblemAddView.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/18.
//

import UIKit

final class ProblemAddView: UIStackView {
    private let segmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["주관식", "객관식"])
        segmentedControl.selectedSegmentIndex = 0
        
        return segmentedControl
    }()
    
    private let problemTitleStackView = ProblemTitleStackView()
    private let problemExampleStackView = ProblemExampleStackView()
    
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
        axis = .vertical
        spacing = 20
    }
    
    private func addSubviews() {
        addArrangedSubview(segmentedControl)
        addArrangedSubview(problemTitleStackView)
        addArrangedSubview(problemExampleStackView)
    }
}
