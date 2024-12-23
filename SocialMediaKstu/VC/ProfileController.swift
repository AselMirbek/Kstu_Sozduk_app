//
//  ProfileController.swift
//  SocialMediaKstu
//
//  Created by Interlink on 20/12/24.
//

import UIKit

class ProfileController: UIViewController {
    // MARK: - Properties
    private let profileView = ProfileView()
    private let viewModel = ProfileViewModel()
    private let loginviewModel = LoginViewModel()

    
    // MARK: - Lifecycle Methods
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        setupTitleCustomNavigationBar(title: "Профиль")
        view.backgroundColor = .systemBackground
        
        setupBindings()
        
    }
    private func setupBindings() {
        viewModel.fetchUserEmail { [weak self] email in
            DispatchQueue.main.async {
                self?.profileView.emailLabel.text = email ?? "No Email"
            }
        }
    }
    func addTargets(){
        profileView.saveButton.addTarget(self, action: #selector(saveProfile),for: .touchUpInside)
        profileView.logOutButton.addTarget(self, action: #selector(logOutProfile),for: .touchUpInside)
    }
    
    
    @objc private func saveProfile() {
        let selectedGender = profileView.genderSegmentedControl.titleForSegment(at: profileView.genderSegmentedControl.selectedSegmentIndex) ?? ""
        let birthDate = profileView.birthDatePicker.date
        
        viewModel.saveProfileData(gender: selectedGender, birthDate: birthDate) { success in
            DispatchQueue.main.async {
                if success {
                    self.showAlert(title: "Success", message: "Profile saved successfully!")
                } else {
                    self.showAlert(title: "Error", message: "Failed to save profile.")
                }
            }
        }
    }
    @objc private func logOutProfile() {
        let alertController = UIAlertController(title: "Выход", message: "Вы действительно хотите выйти?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { _ in
            // Вызываем метод для выхода из системы
            self.loginviewModel.logOut()
            // Переход на экран логина
                   if let tabBarController = self.tabBarController as? TabBarController {
                       tabBarController.checkUserAuthentication()  // Перепроверяем состояние и показываем экран логина
                   }
        }))
        
        present(alertController, animated: true, completion: nil)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
