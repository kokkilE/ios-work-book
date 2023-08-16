//
//  ProblemExampleChoiceViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/16.
//

import UIKit

final class ProblemExampleChoiceViewController: UIViewController {
    private let color = CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
    private let problemExampleChoiceStackView: ProblemExampleChoiceStackView
    
    private lazy var mainStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, scrollView, buttonStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 10
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 12, bottom: 12, right: 12)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 8
        
        return stackView
    }()
    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        
        return scrollView
    }()
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "보기 중 정답 보기를 모두 선택하세요."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        
        return label
    }()
    private lazy var buttonStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, doneButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    private lazy var backButton = {
        let button = UIButton()
        button.setTitle("뒤로", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
        
        return button
    }()
    private lazy var doneButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(touchUpDoneButton), for: .touchUpInside)
        
        return button
    }()
    
    init(examples: [String]) {
        self.problemExampleChoiceStackView = ProblemExampleChoiceStackView(examples: examples)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupProblemExampleChoiceStackView()
        layout()
    }
    
    private func setupView() {
        view.backgroundColor = .clear
    }
    
    private func addSubviews() {
        view.addSubview(mainStackView)
        
        scrollView.addSubview(problemExampleChoiceStackView)
    }
    
    private func setupProblemExampleChoiceStackView() {        
        problemExampleChoiceStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        let width = view.bounds.width * 0.80
        let height = view.bounds.height * 0.40
        
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
            mainStackView.widthAnchor.constraint(equalToConstant: width),
            mainStackView.heightAnchor.constraint(equalToConstant: height),
            
            problemExampleChoiceStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            problemExampleChoiceStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            problemExampleChoiceStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            problemExampleChoiceStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            problemExampleChoiceStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    @objc private func touchUpBackButton() {
        dismiss(animated: true)
    }
    
    @objc private func touchUpDoneButton() {
        
    }
}
