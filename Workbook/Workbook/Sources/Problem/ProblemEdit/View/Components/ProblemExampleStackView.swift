//
//  ProblemExampleStackView.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/26.
//

import UIKit

final class ProblemExampleStackView: UIStackView {
    private var defaultNumberOfExamples = 4
    
    private var exampleTextViewList = [ProblemTextView]()
    private var countTextViewListExceptSpaces: Int {
        get {
            var count = 0
            exampleTextViewList.forEach {
                if !$0.isEmptyExceptSpaces() {
                    count += 1
                }
            }
            return count
        }
    }
    private var removeButtonList = [UIButton]() {
        didSet {
            if removeButtonList.count <= Problem.minimumExampleCount {
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
    
    init(isEditing: Bool = false) {
        super.init(frame: .zero)
        
        setupView()
        
        for _ in 1...defaultNumberOfExamples {
            addExampleItem()
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isNoDuplication() -> Bool {
        var textExceptSpacesSet = Set<String>()
        
        exampleTextViewList.forEach {
            if let text = $0.getTextExceptSpaces() {
                textExceptSpacesSet.insert(text)
            }
        }
        
        if textExceptSpacesSet.count != countTextViewListExceptSpaces {
            return false
        }
        
        return true
    }
    
    func isEnoughExamples() -> Bool {
        if countTextViewListExceptSpaces < Problem.minimumExampleCount {
            return false
        }
        
        return true
    }
    
    func isCanComplete() -> Bool {
        var filledTextViewCount = 0
        
        exampleTextViewList.forEach {
            if !$0.isEmptyExceptSpaces() {
                filledTextViewCount += 1
            }
        }
        
        if filledTextViewCount < Problem.minimumExampleCount {
            return false
        }
        
        var textExceptSpacesSet = Set<String>()
        
        exampleTextViewList.forEach {
            if let text = $0.getTextExceptSpaces() {
                textExceptSpacesSet.insert(text)
            }
        }
        
        if textExceptSpacesSet.count != filledTextViewCount {
            return false
        }
        
        return true
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
    
    func configure(with examples: [String]?) {
        guard let examples else { return }
        
        removeButtonList.removeAll()
        exampleTextViewList.removeAll()
        exampleItemsStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        examples.forEach {
            addExampleItem($0)
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
        addExampleButton.addTarget(self, action: #selector(touchUpAddButton), for: .touchUpInside)
        addExampleButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let exampleStackView = UIStackView(arrangedSubviews: [exampleLabel, addExampleButton])
        exampleStackView.axis = .horizontal
        
        addArrangedSubview(exampleStackView)
        addArrangedSubview(exampleItemsStackView)
        spacing = 4
        axis = .vertical
        alignment = .fill
    }
    
    @objc private func touchUpAddButton() {
        addExampleItem()
    }
    
    private func addExampleItem(_ example: String? = nil) {
        let placeHolder = "문항의 보기를 입력하세요."
        
        let exampleTextView = ProblemTextView(placeHolder: placeHolder)
        exampleTextView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        if let example {
            exampleTextView.text = example
        }
        
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
        guard let index = removeButtonList.firstIndex(where: { $0 == sender }),
              exampleTextViewList[safe: index] != nil else {
            return
        }
        
        removeButtonList.remove(at: index)
        exampleTextViewList.remove(at: index)
        sender.superview?.removeFromSuperview()
    }
}
