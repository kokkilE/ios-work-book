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
        
        font = .systemFont(ofSize: 16)
        text = placeHolder
        textColor = .placeholderText
    }
}

extension ProblemTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let contentSize = sizeThatFits(CGSize(width: bounds.width, height: bounds.height))
        
        bounds = CGRect(origin: .zero, size: contentSize)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if text == placeHolder {
            text = nil
            textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if isEmptyExceptSpaces() {
            text = placeHolder
            textColor = .placeholderText
        }
    }
}