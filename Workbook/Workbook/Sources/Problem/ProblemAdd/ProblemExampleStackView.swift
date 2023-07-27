//
//  ProblemExampleStackView.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/26.
//

import UIKit

final class ProblemExampleStackView: UIStackView {
    private var exampleTextFieldList = [UITextField]()
    
    private let textFieldStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addTextField()
        addTextField()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let exampleLabel = UILabel()
        exampleLabel.font = .systemFont(ofSize: 20)
        exampleLabel.text = "문항 보기"
        exampleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        let addImage = UIImage(systemName: "plus")
        let addExampleButton = UIButton()
        addExampleButton.setImage(addImage, for: .normal)
        addExampleButton.addTarget(self, action: #selector(addTextField), for: .touchUpInside)
        addExampleButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let exampleStackView = UIStackView(arrangedSubviews: [exampleLabel, addExampleButton])
        exampleStackView.axis = .horizontal
        
        addArrangedSubview(exampleStackView)
        addArrangedSubview(textFieldStackView)
        spacing = 4
        axis = .vertical
        alignment = .fill
    }
    
    @objc private func addTextField() {
        let titleTextField = UITextField()
        titleTextField.placeholder = "문항의 보기를 입력하세요."
        titleTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        exampleTextFieldList.append(titleTextField)
        
        textFieldStackView.addArrangedSubview(titleTextField)
    }
}
