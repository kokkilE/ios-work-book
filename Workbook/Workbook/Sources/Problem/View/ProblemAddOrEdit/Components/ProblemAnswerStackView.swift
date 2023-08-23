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
        problemTextView.text = text
    }
    
    private func setupView() {
        let answerLabel = UILabel()
        answerLabel.font = .systemFont(ofSize: 20)
        answerLabel.text = "문항 정답"
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = .systemGray4
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let textFieldStackView = UIStackView(arrangedSubviews: [problemTextView, bottomBorder])
        textFieldStackView.spacing = 4
        textFieldStackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        textFieldStackView.isLayoutMarginsRelativeArrangement = true
        textFieldStackView.axis = .vertical
        
        addArrangedSubview(answerLabel)
        addArrangedSubview(textFieldStackView)
        spacing = 4
        axis = .vertical
        alignment = .fill
    }
}
