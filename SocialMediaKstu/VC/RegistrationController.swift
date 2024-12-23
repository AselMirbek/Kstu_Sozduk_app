//
//  RegistrationController.swift
//  SocialMediaKstu
//
//  Created by Interlink on 11/12/24.
//


import Foundation
import UIKit
import SnapKit
class RegistrationController: UIViewController{
    var password = ""
    var email = ""
    
    lazy var mainView = RegistrationView()
    var mainViewModel: RegistrationProtocol!
override func loadView() {
    view = mainView
}
    init(viewModel: RegistrationProtocol) {
        self.mainViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.mainViewModel.delegate = self
    }
    // MARK: - INIT
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationView()
    addTargets()
    addDelegates()
}

func addDelegates() {
    mainView.loginTextField.delegate = self
    mainView.passwordTextField.delegate = self
    mainView.repeatpasswordTextField.delegate = self
    
}

func addTargets() {
    mainView.registrationButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
}

func setupNavigationView() {
    let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
    self.navigationItem.leftBarButtonItem = backButton
    title = "Registration"
    let eyeButton = UIBarButtonItem(image: UIImage(named: "eye-switch")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(eyeButtonPressed))
    self.navigationItem.rightBarButtonItem = eyeButton
    
    title = "Registration"
}

// MARK: - ACTION BUTTONS
    @objc func enterButtonPressed() {
        guard let email = mainView.loginTextField.text,
              let password = mainView.passwordTextField.text,
              let confirmPassword = mainView.repeatpasswordTextField.text else { return }
        
        if password != confirmPassword {
            // Показываем ошибку
            mainView.passwordError.text = "Passwords do not match"
            mainView.passwordError.isHidden = false
            return
        }
        
        mainViewModel.register(email: email, password: password, password_confirm: confirmPassword)
    

}
   
    @objc func eyeButtonPressed() {
        mainView.passwordTextField.isSecureTextEntry = !mainView.passwordTextField.isSecureTextEntry
        mainView.repeatpasswordTextField.isSecureTextEntry = !mainView.repeatpasswordTextField.isSecureTextEntry
    }
    
@objc func backPressed() {
    navigationController?.popViewController(animated: true)
}

}

// MARK: - EXTENSION
// MARK: - TEXTFIELD DELEGATE

extension RegistrationController: UITextFieldDelegate {

func textFieldShouldReturn(_ LoginTextField: UITextField) -> Bool {
    LoginTextField.resignFirstResponder()
    return true
}

func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String) -> Bool {
        
        let updatedName = textField == mainView.loginTextField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mainView.loginTextField.text
        
        let updatedPassword1 = textField == mainView.passwordTextField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mainView.passwordTextField.text
        
        let updatedPassword2 = textField == mainView.repeatpasswordTextField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mainView.repeatpasswordTextField.text
        
        if let name = updatedName{
            mainView.registrationButton.isEnabled = name.count >= 3 && name.contains("@") && name.contains(".com")
            
            if mainView.registrationButton.isEnabled {
                mainView.registrationButton.backgroundColor = UIColor.colorBlue
            } else {
                mainView.registrationButton.backgroundColor = UIColor.colorGrey
            }
        }
  
        
        if let password2 = updatedPassword2 {
            mainView.registrationButton.isEnabled = password2.count >= 8
            
            if mainView.registrationButton.isEnabled {
                mainView.registrationButton.backgroundColor = UIColor.colorBlue
            } else {
                mainView.registrationButton.backgroundColor = UIColor.colorGrey
            }
        }
        return true
    }
  
}
// MARK: - PASSWORD DELEGATE
extension RegistrationController: RegistrationDelegate {
    func didSucceed(withData data: RegisterResponse) {
        print("Registration successful")
        // Показать Alert о успешной регистрации
              let alertController = UIAlertController(title: "Успешная регистрация",
                                                      message: "Вы успешно зарегистрированы! Теперь вы можете начать пользоваться приложением.",
                                                      preferredStyle: .alert)
              
              // Кнопка OK
              let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                  // Переход на экран аккаунта пользователя (например, на экран профиля)
                  let tabbarController = TabBarController()  // Здесь ваш контроллер профиля
                  tabbarController.modalPresentationStyle = .fullScreen
                  self.present(tabbarController, animated: true, completion: nil)

              }
              
              alertController.addAction(okAction)
              present(alertController, animated: true, completion: nil)
          
    }
    
    func didFail(withError error: Error) {
        mainView.passwordError.isHidden = false
        mainView.passwordTextField.textColor = UIColor.сolorRed
        mainView.repeatpasswordTextField.textColor = UIColor.сolorRed
        print("Registration failed with error: \(error.localizedDescription)")
    }
    
}




