//
//  AppStartConfigurator.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppStartManager {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        // ViewControllers
        let appsVC = SearchBuilder.build()
        appsVC.navigationItem.title = "Search Apps via iTunes"
        appsVC.tabBarItem.title = "Apps"
        
        let songsVC = SearchBuilder.build()
        songsVC.navigationItem.title = "Search Songs via iTunes"
        appsVC.tabBarItem.title = "Songs"

        // NavigationControllers
        let navAppsVC = self.configuredAppsNavigationController
        navAppsVC.viewControllers = [appsVC]
        let navSongsVC = self.configuredSongsNavigationController
        navSongsVC.viewControllers = [songsVC]
        
        // TabBarController
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([navAppsVC, navSongsVC], animated: true)
        if #available(iOS 13.0, *) {
            let tabBarItem1 = UITabBarItem(title: "Apps", image: UIImage(systemName: "apps.iphone"), tag: 0)
            appsVC.tabBarItem = tabBarItem1
            let tabBarItem2 = UITabBarItem(title: "Songs", image: UIImage(systemName: "music.note"), tag: 0)
            songsVC.tabBarItem = tabBarItem2
        } else {
            let tabBarItem1 = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
            appsVC.tabBarItem = tabBarItem1
            let tabBarItem2 = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
            songsVC.tabBarItem = tabBarItem2
        }

        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
    
    private lazy var configuredAppsNavigationController: UINavigationController = {
        let navAppsVC = UINavigationController()
        navAppsVC.navigationBar.barTintColor = UIColor.varnaSoft
        navAppsVC.navigationBar.isTranslucent = false
        navAppsVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: 25)!]
        navAppsVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navAppsVC
    }()
    
    private lazy var configuredSongsNavigationController: UINavigationController = {
        let navSongsVC = UINavigationController()
        navSongsVC.navigationBar.barTintColor = UIColor.greenSoft
        navSongsVC.navigationBar.isTranslucent = false
        navSongsVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: 25)!]
        navSongsVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navSongsVC
    }()
}
