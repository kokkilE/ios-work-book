//
//  SceneDelegate.swift
//  Workbook
//
//  Created by 조향래 on 2023/07/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let workbookListViewController = WorkbookListViewController()
        let navigationController = UINavigationController(rootViewController: workbookListViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
