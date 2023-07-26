//
//  ProblemTitleView.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/26.
//

import UIKit

final class ProblemTitleView: UIStackView {
    private let titleTextView = {
        let titleTextView = UITextView()
        titleTextView.isScrollEnabled = false
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        titleTextView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        return titleTextView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.text = "문항 제목"
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = .systemGray4
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let textFieldStackView = UIStackView(arrangedSubviews: [titleTextView, bottomBorder])
        textFieldStackView.spacing = 4
        textFieldStackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        textFieldStackView.isLayoutMarginsRelativeArrangement = true
        textFieldStackView.axis = .vertical
        
        addArrangedSubview(titleLabel)
        addArrangedSubview(textFieldStackView)
        spacing = 4
        axis = .vertical
        alignment = .fill
    }
}
