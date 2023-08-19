//
//  WorkbookListCell.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import UIKit

final class WorkbookListCell: UICollectionViewCell {
    private let imageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let label = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addsubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, image: UIImage? = nil) {
        label.text = title
        
        guard let image else {
            setupDefaultImage()
            return
        }
        
        imageView.image = image
    }
    
    private func addsubviews() {
        addSubview(imageView)
        addSubview(label)
    }
    
    private func layout() {
        let safe = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 4),
            imageView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 4),
            imageView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -4),
            imageView.heightAnchor.constraint(equalTo: safe.heightAnchor, multiplier: 0.7),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -4),
            label.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -4)
        ])
    }
    
    private func setupDefaultImage() {
        let systemImageName = "folder"
        let image = UIImage(systemName: systemImageName)
        
        imageView.image = image
    }
}
