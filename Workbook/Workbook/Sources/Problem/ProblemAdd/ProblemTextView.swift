//
//  ProblemTextView.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/26.
//

import UIKit

final class ProblemTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        isScrollEnabled = false
        delegate = self
    }
}

extension ProblemTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let contentSize = sizeThatFits(CGSize(width: bounds.width, height: bounds.height))
        
        frame = CGRect(origin: .zero, size: contentSize)
    }
}
