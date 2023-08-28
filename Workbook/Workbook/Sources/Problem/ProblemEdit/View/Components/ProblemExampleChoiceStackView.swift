//
//  ProblemExampleChoiceStackView.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/09.
//

import UIKit
import Combine

final class ProblemExampleChoiceStackView: UIStackView {
    private let defaultColor = UIColor.white
    private let selectedColor = UIColor(cgColor: CGColor(red: 0.0, green: 0.55, blue: 0.05, alpha: 0.4))
    
    private var exampleButtonList = {
        let buttonList = [UIButton]()
        
        return buttonList
    }()
    
    var selectedIndexList = Set<Int>()
    @Published var isAnswerSelected = false
    
    init(examples: [String]?) {
        super.init(frame: .zero)
        
        setupView()
        setupExampleLabelList(examples: examples)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        axis = .vertical
        alignment = .leading
        spacing = 4
    }
    
    func setupExampleLabelList(examples: [String]?) {
        examples?.forEach {
            let button = createButton(from: $0)
            
            exampleButtonList.append(button)
            addArrangedSubview(button)
            
            button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        }
    }
    
    private func createButton(from example: String) -> UIButton {
        let button = UIButton()
        button.setTitle(example, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = defaultColor
        button.layer.cornerRadius = 10
        
        guard let titleLabel = button.titleLabel else { return button }
        
        titleLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -8)
        ])
        
        button.addTarget(self, action: #selector(touchUpButton), for: .touchUpInside)
        
        return button
    }
    
    @objc private func touchUpButton(sender: UIButton) {
        guard let index = exampleButtonList.firstIndex(where: {
            $0.titleLabel?.text == sender.titleLabel?.text }) else {
            return
        }
        
        if selectedIndexList.contains(where: { $0 == index }) {
            selectedIndexList.remove(index)
            exampleButtonList[index].backgroundColor = defaultColor
        } else {
            selectedIndexList.insert(index)
            exampleButtonList[index].backgroundColor = selectedColor
        }
        
        isAnswerSelected = !selectedIndexList.isEmpty
    }
}
