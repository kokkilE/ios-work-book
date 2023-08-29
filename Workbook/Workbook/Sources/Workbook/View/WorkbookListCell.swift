//
//  WorkbookListCell.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import UIKit

final class WorkbookListCell: UICollectionViewCell {
    private lazy var mainStackView = {
        let stackView = UIStackView(arrangedSubviews: [workbookTitltLabel, problemCountLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    private let workbookTitltLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 3
        label.textColor = .black
        label.text = "asldkalsdasld"
        
        return label
    }()
    private let problemCountLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        label.textColor = .systemGray
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addsubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, problemCount: Int) {
        workbookTitltLabel.text = title
        problemCountLabel.text = "\(problemCount)개 문제"
    }
    
    private func setupView() {
        backgroundColor = .white
        
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOffset = .init(width: 2, height: 2)
        layer.shadowOpacity = 0.5
    }
    
    private func addsubviews() {
        addSubview(mainStackView)
    }
    
    private func layout() {
        let safe = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 12),
            mainStackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -12),
            mainStackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -12)
        ])
    }
}
