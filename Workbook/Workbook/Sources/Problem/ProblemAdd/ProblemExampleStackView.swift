//
//  ProblemExampleStackView.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/26.
//

import UIKit

final class ProblemExampleStackView: UIStackView {
    private var exampleTextViewList = [ProblemTextView]()
    private var removeButtonList = [UIButton]()
    
    private let exampleItemStackView = {
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
        addExampleItem()
        addExampleItem()
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
        addExampleButton.addTarget(self, action: #selector(addExampleItem), for: .touchUpInside)
        addExampleButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let exampleStackView = UIStackView(arrangedSubviews: [exampleLabel, addExampleButton])
        exampleStackView.axis = .horizontal
        
        addArrangedSubview(exampleStackView)
        addArrangedSubview(exampleItemStackView)
        spacing = 4
        axis = .vertical
        alignment = .fill
    }
    
    @objc private func addExampleItem() {
        let exampleTextView = ProblemTextView(placeHolder: "문항의 보기를 입력하세요.")
        exampleTextView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        let removeImage = UIImage(systemName: "xmark")
        let removeButton = UIButton()
        removeButton.setImage(removeImage, for: .normal)
        removeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        removeButton.addTarget(self, action: #selector(removeExampleItem), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [exampleTextView, removeButton])
        
        removeButtonList.append(removeButton)
        exampleTextViewList.append(exampleTextView)
        exampleItemStackView.addArrangedSubview(stackView)
    }
    
    @objc private func removeExampleItem(_ sender: UIButton) {
        guard let index = removeButtonList.firstIndex(where: { $0 == sender } ),
              let superView = sender.superview,
              exampleTextViewList[safe: index] != nil else {
            return
        }
        
        removeButtonList.remove(at: index)
        exampleTextViewList.remove(at: index)
        exampleItemStackView.removeArrangedSubview(superView)
    }
}
