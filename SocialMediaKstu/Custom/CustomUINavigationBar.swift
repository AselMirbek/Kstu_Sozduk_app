//
//  CustomUINavigationBar.swift
//  SocialMediaKstu
//
//  Created by Interlink on 23/12/24.
//

import UIKit
import Foundation
extension UIViewController {
    func setupCustomNavigationBar(title: String, backButtonAction: Selector?, titleColor: UIColor = .black, titleFontSize: CGFloat = 20) {
        self.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: titleColor,
            .font: UIFont.systemFont(ofSize: titleFontSize, weight: .bold)
        ]
        
        // Кнопка "Назад"
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: backButtonAction)
        self.navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.barTintColor = .white

        
    }
    func setupTitleCustomNavigationBar(title: String, titleColor: UIColor = .black, titleFontSize: CGFloat = 20) {
        self.title = title
              self.navigationController?.navigationBar.titleTextAttributes = [
                  .foregroundColor: titleColor,
                  .font: UIFont.systemFont(ofSize: titleFontSize, weight: .bold)
              ]
              
        navigationController?.navigationBar.barTintColor = .white

    }}
