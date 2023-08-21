//
//  ProblemListViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import UIKit
import Combine

final class ProblemListViewController: UIViewController {
    enum Section {
        case main
    }
    
    private let problemControlView = ProblemControlView()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.register(ProblemListCell.self, forCellReuseIdentifier: ProblemListCell.reuseIdentifier)
        
        return tableView
    }()
    
    private let viewModel = ProblemViewModel()
    private var dataSource: UITableViewDiffableDataSource<Section, Problem>?
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationItems()
        addSubviews()
        layout()
        setupDataSource()
        bind()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationItems() {
        setupNavigationTitle()
        setupNavigationLeftBarButtonItem()
        setupNavigationRightBarButtonItem()
    }
    
    private func setupNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = viewModel.workbookTitle
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let halfViewWidth = view.frame.width * 0.50
        titleLabel.widthAnchor.constraint(equalToConstant: halfViewWidth).isActive = true
        
        navigationItem.titleView = titleLabel
    }
    
    private func setupNavigationLeftBarButtonItem() {
        let systemImageName = "arrow.left"
        let backImage = UIImage(systemName: systemImageName)
        
        let leftBarButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(dismissProblemListViewController))
        leftBarButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    private func setupNavigationRightBarButtonItem() {
        let systemImageName = "plus"
        let addImage = UIImage(systemName: systemImageName)
        
        let rightBarButton = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(addProblem))
        rightBarButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func dismissProblemListViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addProblem() {
        let problemAddViewController = ProblemAddViewController()
        
        navigationController?.pushViewController(problemAddViewController, animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(problemControlView)
        view.addSubview(tableView)
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            problemControlView.topAnchor.constraint(equalTo: safe.topAnchor),
            problemControlView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            problemControlView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            problemControlView.heightAnchor.constraint(equalTo: safe.heightAnchor, multiplier: 0.10),
            
            tableView.topAnchor.constraint(equalTo: problemControlView.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Problem>(tableView: tableView) { tableView, indexPath, problem in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProblemListCell.reuseIdentifier,
                for: indexPath) as? ProblemListCell else {
                return UITableViewCell()
            }
            
            cell.configure(title: problem.question)
            
            return cell
        }
    }
    
    private func bind() {
        viewModel.requestProblemListPublisher()?
            .sink { [weak self] problemList in
                self?.applySnapshot(problemList: problemList)
            }
            .store(in: &subscriptions)
    }
    
    private func applySnapshot(problemList: [Problem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Problem>()

        snapshot.appendSections([.main])
        snapshot.appendItems(problemList)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension ProblemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let problemAddViewController = ProblemAddViewController()
        
        navigationController?.pushViewController(problemAddViewController, animated: true)
    }
}
