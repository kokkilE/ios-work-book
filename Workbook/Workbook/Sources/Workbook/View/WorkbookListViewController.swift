//
//  WorkbookListViewController.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import UIKit
import Combine

final class WorkbookListViewController: UIViewController {
    enum Section {
        case main
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.register(WorkbookListCell.self, forCellWithReuseIdentifier: WorkbookListCell.reuseIdentifier)
        collectionView.backgroundColor = .systemGray6
        
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Workbook>?
    private let viewModel = WorkbookViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        layout()
        setupNavigationLeftBarButtonItem()
        setupNavigationRightBarButtonItem()
        setupDataSource()
        bind()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func layout() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupNavigationLeftBarButtonItem() {
        let systemImageName = "list.triangle"
        let title = "문제집"
        
        let image = UIImage(systemName: systemImageName)
        let titleImageView = UIImageView(image: image)
        titleImageView.tintColor = .systemGreen
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
        let stackView = UIStackView(arrangedSubviews: [titleImageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fill
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: stackView)
    }
    
    private func setupNavigationRightBarButtonItem() {
        let systemImageName = "folder.fill.badge.plus"
        let image = UIImage(systemName: systemImageName)
        
        let rightBarButton = UIBarButtonItem(image: image,
                                             style: .plain,
                                             target: self,
                                             action: #selector(addWorkbook))
        rightBarButton.tintColor = .systemGreen
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func addWorkbook() {
        let alertManager = AlertManager()
        
        let alert = alertManager.createNewWorkbookAlert() { [weak self] title in
            if title.isEmptyExceptSpaces() {
                let errorAlert = alertManager.createErrorAlert(error: WorkbookError.emptyTitle)
                self?.present(errorAlert, animated: true)
                
                return
            }
            
            self?.viewModel.addWorkbook(title)
        }
        
        self.present(alert, animated: true)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Workbook>(collectionView: collectionView) { collectionView, indexPath, workbook in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WorkbookListCell.reuseIdentifier,
                for: indexPath) as? WorkbookListCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(title: workbook.getTitle(), problemCount: workbook.getProblemsCount())
            
            return cell
        }
    }
    
    private func bind() {
        viewModel.requestWorkbookListPublisher()
            .sink { [weak self] workbookList in
                self?.applySnapshot(workbookList: workbookList)
            }
            .store(in: &subscriptions)
    }
    
    private func applySnapshot(workbookList: [Workbook]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Workbook>()

        snapshot.appendSections([.main])
        snapshot.appendItems(workbookList)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension WorkbookListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        do {
            try viewModel.selectWorkbook(at: indexPath)
            let problemListViewController = ProblemListViewController()
            problemListViewController.delegate = self
            
            navigationController?.pushViewController(problemListViewController, animated: true)
        } catch {
            return
        }
    }
}

extension WorkbookListViewController: DataUpdatable {
    func updateData() {
        collectionView.reloadData()
    }
}
