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
    
    private let titleStackView = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "문항의 제목"
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let titleTextField = UITextField()
        titleTextField.placeholder = "문항의 제목을 입력하세요."
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleTextField])
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = UIColor.gray.cgColor
        stackView.spacing = 12
        stackView.backgroundColor = .systemGray6
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
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
        axis = .vertical
        spacing = 20
    }
    
    private func addSubviews() {
        addArrangedSubview(segmentedControl)
        addArrangedSubview(titleStackView)
    }
}
