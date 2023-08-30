//
//  ProblemAnswerStackView.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/04.
//

import UIKit

final class ProblemAnswerStackView: UIStackView {
    private let problemTextView = ProblemTextView(placeHolder: "문항 정답을 작성하세요.")
    
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
    
    func getAnswer() -> String {
        return problemTextView.text
    }
    
    func configure(with text: String?) {
        guard let text else { return }
        
        problemTextView.text = text
    }
    
    private func setupView() {
        let answerLabel = UILabel()
        answerLabel.font = .systemFont(ofSize: 20)
        answerLabel.text = "문항 정답"
        
        addArrangedSubview(answerLabel)
        addArrangedSubview(problemTextView)
        spacing = 12
        axis = .vertical
        alignment = .fill
    }
}
