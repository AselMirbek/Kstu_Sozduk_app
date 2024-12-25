//  TabBarController.swift
//  SocialMediaKstu
//
//  Created by Interlink on 4/12/24.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Принудительно устанавливаем светлую тему
            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
            }
        self.setupTabs()
        self.selectedIndex = 1
        self.tabBar.tintColor = UIColor.colorBlue;       self.tabBar.unselectedItemTintColor = .gray
        checkUserAuthentication()
        UITabBar.appearance().backgroundColor = .white
        self.tabBar.backgroundImage = UIImage() 
        self.tabBar.shadowImage = UIImage()
        self.tabBar.isTranslucent = false
    }
     func checkUserAuthentication() {
         if Auth.auth().currentUser != nil {
               // Если пользователь авторизован, показываем табы
               setupTabs()
           } else {
               // Если пользователь не авторизован, показываем экран логина
               showLoginScreen()
           }
       }

    private func setupTabs() {
        let home = createNav(with: "Главная", and: UIImage(systemName: "house.fill"), vc: MainController())
        let wallet = createNav(with: "Статистика", and: UIImage(systemName: "chart.line.uptrend.xyaxis"), vc: StatisticsViewController())
        let profile = createNav(with: "Профиль", and: UIImage(systemName: "person.fill"), vc: ProfileController())

        self.setViewControllers([home, wallet, profile], animated: true)

        if let items = self.tabBar.items {
            for item in items {
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
                item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) 
            }
        }
    }

    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
    private func showLoginScreen() {
           let loginViewController = LogInController(viewModel: LoginViewModel())
           loginViewController.modalPresentationStyle = .fullScreen
           self.present(loginViewController, animated: true, completion: nil)
       }

}
