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
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.text = "문항 제목"
        
        let titleTextField = UITextField()
        titleTextField.placeholder = "문항의 제목을 입력하세요."
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = .systemGray4
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let textFieldStackView = UIStackView(arrangedSubviews: [titleTextField, bottomBorder])
        textFieldStackView.spacing = 4
        textFieldStackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        textFieldStackView.isLayoutMarginsRelativeArrangement = true
        textFieldStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, textFieldStackView])
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.alignment = .fill
                
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
