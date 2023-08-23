//
//  ProblemTextView.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/26.
//

import UIKit

final class ProblemTextView: UITextView {
    private let placeHolder: String?
    
    init(placeHolder: String? = nil) {
        self.placeHolder = placeHolder
        
        super.init(frame: .zero, textContainer: .none)
        
        setupView()
        setupAttributedText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isEmptyExceptSpaces() -> Bool {
        guard var copiedText = text,
              copiedText != placeHolder else { return true }
        
        copiedText.removeAll { $0 == " " || $0 == "\n" }
        
        if copiedText.isEmpty {
            return true
        }
        
        return false
    }
    
    func getTextExceptSpaces() -> String? {
        guard var copiedText = text,
              copiedText != placeHolder else { return nil }
        
        copiedText.removeAll { $0 == " " || $0 == "\n" }
        
        return copiedText
    }
        
    private func setupView() {
        isScrollEnabled = false
        delegate = self
        
        text = placeHolder
    }
    
    private func setupAttributedText() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.placeholderText,
            .font: UIFont.systemFont(ofSize: 16),
            .kern: 1.0,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSAttributedString(string: self.text, attributes: attributes)
        
        attributedText = attributedString
    }
}

extension ProblemTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textColor = .black
        
        if text == placeHolder {
            text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if isEmptyExceptSpaces() {
            text = placeHolder
            textColor = .placeholderText
        }
    }
}
