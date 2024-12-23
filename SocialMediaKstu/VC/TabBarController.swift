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
        self.setupTabs()
        self.selectedIndex = 1
        self.tabBar.tintColor = UIColor.colorBlue;       self.tabBar.unselectedItemTintColor = .gray
        checkUserAuthentication()
        // Установка белого фона для tabBar
        UITabBar.appearance().backgroundColor = .white
        self.tabBar.backgroundImage = UIImage() // Прозрачный фон
        self.tabBar.isTranslucent = false
    }
     func checkUserAuthentication() {
           if let user = Auth.auth().currentUser {
               // Если пользователь авторизован, показываем табы
               setupTabs()
           } else {
               // Если пользователь не авторизован, показываем экран логина
               showLoginScreen()
           }
       }

    private func setupTabs() {
        // Создаем контроллеры с иконками и заголовками
        let home = createNav(with: "Главная", and: UIImage(systemName: "house.fill"), vc: MainController())
        let wallet = createNav(with: "Статистика", and: UIImage(systemName: "chart.line.uptrend.xyaxis"), vc: StatisticsViewController())
        let profile = createNav(with: "Профиль", and: UIImage(systemName: "person.fill"), vc: ProfileController())

        // Устанавливаем контроллеры для TabBarController
        self.setViewControllers([home, wallet, profile], animated: true)

        // Убедимся, что иконки равномерно распределены
        if let items = self.tabBar.items {
            for item in items {
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2) // Поднятие текста ближе к иконке
                item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Без отступов для иконки
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
