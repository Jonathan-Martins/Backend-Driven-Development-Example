//
//  AppDelegate.swift
//  UIDevelpment
//
//  Created by Jonathan Oliveira on 18/06/20.
//  Copyright © 2020 Jonathan Oliveira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBar()
        setupInitialViewController()
        return true
    }
}

private extension AppDelegate {
    
    private func setupNavigationBar() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController()//UINavigationController(rootViewController: MainViewController())
        window?.makeKeyAndVisible()
    }
    
    private func setupInitialViewController() {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
    }
}

