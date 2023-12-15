//
//  SceneDelegate.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)

        if UserDefaults.standard.value(forKey: "state") != nil {
            window?.rootViewController = Builder.createTabBar()
        } else {
            window?.rootViewController = Builder.createWelcomeVC()
        }
        window?.makeKeyAndVisible()
    }
}


