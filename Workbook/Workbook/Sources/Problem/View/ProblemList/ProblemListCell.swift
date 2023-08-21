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
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addsubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        label.text = title
    }
    
    private func addsubviews() {
        addSubview(label)
    }
    
    private func layout() {
        let safe = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: safe.topAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -4),
            label.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -4)
        ])
    }
}
