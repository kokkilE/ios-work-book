//
//  ReuseIdentifying.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import UIKit

public protocol ReuseIdentifying {}

extension ReuseIdentifying {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifying {}
