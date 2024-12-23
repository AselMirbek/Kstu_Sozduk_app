//
//  LogInModel.swift
//  SocialMediaKstu
//
//  Created by Interlink on 18/12/24.
//

import Foundation
import FirebaseAuth
protocol LoginProtocol {
    var delegate: LoginDelegate? { get set }
    func login(username: String, password: String)
}
protocol LoginDelegate: AnyObject {
    func didSucceed(withData data: LoginResponse)
    func didFail(withError error: Error)
}
struct LoginResponse {
    let email: String
}

class LoginViewModel: LoginProtocol {
    weak var delegate: LoginDelegate?

    func login(username: String, password: String) {
           // Проверка входных данных
           guard !username.isEmpty, !password.isEmpty else {
               let error = NSError(domain: "LoginError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Username or password cannot be empty"])
               delegate?.didFail(withError: error)
               return
           }
           
           // Авторизация через Firebase
           Auth.auth().signIn(withEmail: username, password: password) { [weak self] result, error in
               DispatchQueue.main.async {
                   if let error = error {
                       self?.delegate?.didFail(withError: error)
                   } else if let result = result {
                       let response = LoginResponse(email: result.user.email ?? "Unknown")

                       self?.delegate?.didSucceed(withData: response)
                   }
               }
           }
       
        }
    // Функция для выхода из аккаунта
       func logOut() {
           do {
               try Auth.auth().signOut()  // Попытка выхода из Firebase
               print("User successfully logged out")
           } catch let error {
               print("Error signing out: \(error.localizedDescription)")
           }
       }
  
}
