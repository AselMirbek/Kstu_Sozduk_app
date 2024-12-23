//
//  LoginController.swift
//  SocialMediaKstu
//
//  Created by Interlink on 11/12/24.
//
import UIKit
import SnapKit
class LogInController: UIViewController {

            
        lazy var mainView = LoginView()
      var mainViewModel: LoginProtocol!
        // MARK: - INIT
        override func loadView() {
            view = mainView
        }
        
        init(viewModel: LoginProtocol) {
            self.mainViewModel = viewModel
            super.init(nibName: nil, bundle: nil)
            self.mainViewModel.delegate = self
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            addTargets()
            addDelegates()
            print("Navigation controller: \(navigationController)")

            
        }
        

        // MARK: - UI SETUP
        func addDelegates() {
            mainView.loginTextField.delegate = self
            mainView.passwordTextField.delegate = self
            mainView.registrationToNextTappedButton.isUserInteractionEnabled = true

        }
        
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationItem.setHidesBackButton(true, animated: false)
        }
        
    func addTargets() {
        
        mainView.registrationToNextTappedButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        mainView.loginButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        //  mainView.passwordTextField.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        if let button = mainView.passwordTextField.rightView as? UIButton {
                button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
            }}
        
            @objc func enterButtonPressed() {
                if mainView.loginButton.backgroundColor != UIColor.colorGrey {
                    guard let name = mainView.loginTextField.text,
                          let password = mainView.passwordTextField.text
                    else {
                        print("Email or password is empty.")
                        return
                    }
                    mainViewModel.login(username: name, password: password)
                }
            }
    
        
    @objc func registerButtonPressed() {
        print("Register button pressed")

        let registrationViewModel = RegistrationViewModel()
        let vc = RegistrationController(viewModel: registrationViewModel)
        /* if navigationController == nil {
               print("NavigationController is nil. Ensure LogInController is embedded in a UINavigationController.")
           } else {
               navigationController?.pushViewController(vc, animated: true)
           }*/
       // navigationController?.pushViewController(vc, animated: true)
           guard let navigationController = self.navigationController else {
               print("NavigationController is nil.")
               return
           }
           
           print("Attempting to push RegistrationController")
           navigationController.pushViewController(vc, animated: true)
    }

            
    }

   
// MARK: - UITextFieldDelegate
extension LogInController: UITextFieldDelegate {
    
    // Password visibility
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        mainView.passwordTextField.isSecureTextEntry.toggle()
        // Переключаем состояние кнопки (если текстовое поле скрывает текст, показываем "eye-disabled", иначе "eye")
        if mainView.passwordTextField.isSecureTextEntry {
               sender.setImage(UIImage(named: "eye-disabled"), for: .normal) // Иконка скрытого пароля
           } else {
               sender.setImage(UIImage(named: "eye"), for: .normal) // Иконка видимого пароля
           }
        //sender.isSelected = !sender.isSelected
        //mainView.passwordTextField.isSecureTextEntry = !mainView.passwordTextField.isSecureTextEntry
    }
    
    func textFieldShouldReturn(_ LoginTextField: UITextField) -> Bool {
        LoginTextField.resignFirstResponder()
        return true
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {

            let updatedName = textField == mainView.loginTextField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mainView.loginTextField.text
            let updatedPassword = textField == mainView.passwordTextField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mainView.passwordTextField.text
        
        if let name = updatedName, let password = updatedPassword {
            
            mainView.loginButton.isEnabled = name.count >= 3 && password.count >= 8
            
            if mainView.loginButton.isEnabled {
                mainView.loginButton.backgroundColor = UIColor.colorBlue
            } else {
                mainView.loginButton.backgroundColor = UIColor.colorGrey
            }
        }
        return true
    }
    
}

// MARK: - LOGIN DELEGATE
extension LogInController: LoginDelegate {
    
    func didSucceed(withData data: LoginResponse) {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func didFail(withError error: Error) {
        mainView.statusLabel.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.mainView.statusLabel.isHidden = true
        }
        
        mainView.loginTextField.textColor = UIColor.сolorRed
        mainView.passwordTextField.textColor = UIColor.сolorRed
        mainView.nameLine.backgroundColor = UIColor.сolorRed
        mainView.passwordLine.backgroundColor = UIColor.сolorRed
        print("Login failed with error: \(error.localizedDescription)")
    }
    
}
