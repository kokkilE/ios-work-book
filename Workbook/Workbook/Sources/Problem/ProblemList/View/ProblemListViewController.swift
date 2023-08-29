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
        tableView.backgroundColor = .systemGray6
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.register(ProblemListCell.self, forCellReuseIdentifier: ProblemListCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let viewModel = ProblemListViewModel()
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
        view.backgroundColor = .systemGray6
    }
    
    private func setupNavigationItems() {
        setupNavigationTitle()
        setupNavigationLeftBarButtonItem()
        setupNavigationRightBarButtonItem()
    }
    
    private func setupNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = viewModel.getWorkbookTitle()
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
        leftBarButton.tintColor = AppColor.deepGreen
        
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    private func setupNavigationRightBarButtonItem() {
        let systemImageName = "plus.app"
        let image = UIImage(systemName: systemImageName)
        
        let rightBarButton = UIBarButtonItem(image: image,
                                             style: .plain,
                                             target: self,
                                             action: #selector(addProblem))
        rightBarButton.tintColor = AppColor.deepGreen
        
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
            problemControlView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 4),
            problemControlView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 8),
            problemControlView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -8),
            
            tableView.topAnchor.constraint(equalTo: problemControlView.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -8),
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
            
            let cellTitle = "\(indexPath.row + 1). \(problem.question)"
            cell.configure(title: cellTitle)
            
            return cell
        }
    }
    
    private func bind() {
        viewModel.requestProblemListPublisher()?
            .sink { [weak self] problemList in
                self?.applySnapshot(problemList: problemList)
                self?.problemControlView.configureProblemCountLabel(problemList.count)
            }
            .store(in: &subscriptions)
        
        problemControlView.$isSolveButtonTapped
            .sink { [weak self] isSolveButtonTapped in
                guard isSolveButtonTapped else { return }
                
                self?.presentProblemSolveViewController()
            }
            .store(in: &subscriptions)
    }
    
    private func applySnapshot(problemList: [Problem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Problem>()

        snapshot.appendSections([.main])
        snapshot.appendItems(problemList)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func presentProblemSolveViewController() {
        let problemSolveViewController = ProblemSolveViewController()
        
        navigationController?.pushViewController(problemSolveViewController, animated: true)
    }
}

extension ProblemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let problem = viewModel.getProblem(at: indexPath.item) else { return }
                
        let problemAddViewController = ProblemEditViewController(problem: problem)
        
        navigationController?.pushViewController(problemAddViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { [weak self] _, _, _ in
            self?.showDeleteAlert(indexPath.item)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    private func showDeleteAlert(_ index: Int) {
        let alert = AlertManager().createDeleteProblemAlert() { [weak self] in
            self?.viewModel.deleteProblem(at: index)
            self?.tableView.reloadData()
        }
        
        present(alert, animated: true)
    }
}
