//
//  ProblemListCell.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/21.
//

import UIKit

final class ProblemListCell: UITableViewCell {
    private let label = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        addsubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        setupAttributedText(title)
    }
    
    private func setupView() {
        accessoryType = .disclosureIndicator
    }
    
    private func addsubviews() {
        addSubview(label)
    }
    
    private func layout() {
        let safe = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 12),
            label.widthAnchor.constraint(equalTo: safe.widthAnchor, multiplier: 0.80),
            label.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupAttributedText(_ text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 20),
            .kern: 1.0,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        
        label.attributedText = attributedString
    }
}
