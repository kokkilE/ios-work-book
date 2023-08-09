//
//  ProblemExampleStackView.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/26.
//

import UIKit

final class ProblemExampleStackView: UIStackView {
    private let minimumExampleCount = 2
    private var defaultNumberOfExamples = 4
    
    private var exampleTextViewList = [ProblemTextView]()
    private var removeButtonList = [UIButton]() {
        didSet {
            if removeButtonList.count <= minimumExampleCount {
                removeButtonList.forEach { $0.isHidden = true }
                return
            }

            removeButtonList.forEach { $0.isHidden = false }
        }
    }
    
    private let exampleItemsStackView = {
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
        
        for _ in 1...defaultNumberOfExamples {
            addExampleItem()
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isCanComplete() -> Bool {
        var filledTextViewCount = 0
        
        exampleTextViewList.forEach {
            if !$0.isEmptyExceptSpaces() {
                filledTextViewCount += 1
            }
        }
        
        if filledTextViewCount >= minimumExampleCount {
            return true
        }
        
        return false
    }
    
    func getExampleList() -> [String] {
        var exampleList = [String]()
        
        exampleTextViewList.forEach {
            if !$0.isEmptyExceptSpaces() {
                exampleList.append($0.text)
            }
        }
        
        return exampleList
    }
    
    func removeEmptyTextView() {
        let indexRange = exampleTextViewList.endIndex...exampleTextViewList.startIndex
        
        for index in indexRange {
            if exampleTextViewList[index].isEmptyExceptSpaces() {
                exampleTextViewList.remove(at: index)
            }
        }
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
        addArrangedSubview(exampleItemsStackView)
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
        removeButton.tintColor = .systemRed
        removeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        removeButton.addTarget(self, action: #selector(removeExampleItem), for: .touchUpInside)

        let itemStackView = UIStackView(arrangedSubviews: [exampleTextView, removeButton])
        
        removeButtonList.append(removeButton)
        exampleTextViewList.append(exampleTextView)
        exampleItemsStackView.addArrangedSubview(itemStackView)
    }
    
    @objc private func removeExampleItem(_ sender: UIButton) {
        guard let index = removeButtonList.firstIndex(where: { $0 == sender } ),
              exampleTextViewList[safe: index] != nil else {
            return
        }
        
        removeButtonList.remove(at: index)
        exampleTextViewList.remove(at: index)
        sender.superview?.removeFromSuperview()
    }
}
