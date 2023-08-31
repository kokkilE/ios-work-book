//
//  ProblemTitleStackView.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/26.
//

import UIKit

final class ProblemTitleStackView: UIStackView {
    private let problemTextView = ProblemTextView(placeHolder: "문항 제목을 작성하세요.")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isCanComplete() -> Bool {
        return !problemTextView.isEmptyExceptSpaces()
    }
    
    func getTitle() -> String {
        return problemTextView.text
    }
    
    func configure(with text: String) {        
        problemTextView.configure(text)
    }
    
    private func setupView() {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.text = "문항 제목"
        
        spacing = 12
        axis = .vertical
        alignment = .fill
        
        addArrangedSubview(titleLabel)
        addArrangedSubview(problemTextView)
    }
}
