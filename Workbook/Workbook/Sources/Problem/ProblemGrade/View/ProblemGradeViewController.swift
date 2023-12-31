//
//  ProblemGradeViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/08/30.
//

import UIKit
import Combine

class ProblemGradeViewController: UIViewController {
    enum Section {
        case main
    }
    
    private let resultControlView = ResultControlView()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.register(ProblemGradeResultListCell.self, forCellReuseIdentifier: ProblemGradeResultListCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return tableView
    }()
    
    private let viewModel: ProblemGradeViewModel
    private var dataSource: UITableViewDiffableDataSource<Section, Problem>?
    private var subscriptions = Set<AnyCancellable>()
        
    init(viewModel: UserAnswerProcessing) {
        self.viewModel = ProblemGradeViewModel(viewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        layout()
        setupResultControlView()
        setupDataSource()
        bind()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
    }
    
    private func addSubviews() {
        view.addSubview(resultControlView)
        view.addSubview(tableView)
    }
    
    private func setupResultControlView() {
        resultControlView.configureOverviewLabel(
            problemCount: viewModel.problemCount,
            correctProblemCount: viewModel.correctProblemCount
        )
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            resultControlView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 4),
            resultControlView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 8),
            resultControlView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -8),
            
            tableView.topAnchor.constraint(equalTo: resultControlView.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Problem>(tableView: tableView) { [weak self] tableView, indexPath, problem in
            guard let self,
                  let cell = tableView.dequeueReusableCell(
                    withIdentifier: ProblemGradeResultListCell.reuseIdentifier,
                    for: indexPath) as? ProblemGradeResultListCell else {
                return UITableViewCell()
            }
            
            let cellTitle = problem.question
            let cellColor = getCellColor(indexPath: indexPath)
            cell.configure(title: cellTitle)
            cell.configureBackgroundColor(with: cellColor)
            
            return cell
        }
    }
    
    private func bind() {
        viewModel.requestProblemListPublisher()?
            .sink { [weak self] problemList in
                self?.viewModel.problemList = problemList
                self?.applySnapshot(problemList: problemList)
            }
            .store(in: &subscriptions)
        
        resultControlView.$isExplainAllProblemButtonTapped
            .sink { [weak self] _ in
                let problemList = self?.viewModel.problemList
            }
            .store(in: &subscriptions)
        
        resultControlView.$isExplainWrongProblemButtonTapped
            .sink { [weak self] _ in
                let problemList = self?.viewModel.getWrongProblemList()
            }
            .store(in: &subscriptions)
    }
    
    private func applySnapshot(problemList: [Problem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Problem>()

        snapshot.appendSections([.main])
        snapshot.appendItems(problemList)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func getCellColor(indexPath: IndexPath) -> UIColor {
        if viewModel.isCorrectAnswer(indexPath) {
            return .white
        }
        
        return AppColor.lightRed
    }
    
    private func presentProblemExplainViewController() {
        let problemExplainViewController = ProblemExplainViewController()
        
        navigationController?.pushViewController(problemExplainViewController, animated: true)
    }
}

extension ProblemGradeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let problem = viewModel.getProblem(at: indexPath.item)
        
        presentProblemExplainViewController()
    }
}
