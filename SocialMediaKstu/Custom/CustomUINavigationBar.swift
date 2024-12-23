//
//  CustomUINavigationBar.swift
//  SocialMediaKstu
//
//  Created by Interlink on 23/12/24.
//

import UIKit
import Foundation
extension UIViewController {
    func setupCustomNavigationBar(title: String, backButtonAction: Selector?, titleColor: UIColor = .black, titleFont: UIFont = UIFont.systemFont(ofSize: 18)) {
        // Устанавливаем кастомный титул
        self.title = title
        // Настройка цвета и шрифта титула
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: titleColor,
            .font: titleFont
        ]
        
        // Кнопка "Назад"
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: backButtonAction)
        self.navigationItem.leftBarButtonItem = backButton
        
        
    }
    func setupTitleCustomNavigationBar(title: String, titleColor: UIColor = .black, titleFont: UIFont = UIFont.systemFont(ofSize: 18)) {
        // Устанавливаем кастомный титул
        self.title = title
        // Настройка цвета и шрифта титула
              self.navigationController?.navigationBar.titleTextAttributes = [
                  .foregroundColor: titleColor,
                  .font: titleFont
              ]
              
      
    }}
