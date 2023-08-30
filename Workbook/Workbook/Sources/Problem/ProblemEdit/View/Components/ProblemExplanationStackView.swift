//
//  ProblemExplanationStackView.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/24.
//

import UIKit

final class ProblemExplanationStackView: UIStackView {
    private let problemTextView = ProblemTextView(placeHolder: "문항 해설을 작성하세요.")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getText() -> String? {
        if problemTextView.isEmptyExceptSpaces() { return nil }
        
        return problemTextView.text
    }
    
    func configure(with text: String?) {
        guard let text else { return }
        
        problemTextView.text = text
    }
    
    private func setupView() {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.text = "문항 해설(선택)"
        
        addArrangedSubview(titleLabel)
        addArrangedSubview(problemTextView)
        spacing = 12
        axis = .vertical
        alignment = .fill
    }
}
