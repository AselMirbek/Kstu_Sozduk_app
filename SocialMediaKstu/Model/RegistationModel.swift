//
//  RegistationModel.swift
//  SocialMediaKstu
//
//  Created by Interlink on 18/12/24.
//

import Foundation
import FirebaseAuth
protocol RegistrationProtocol: AnyObject {
    var delegate: RegistrationDelegate? { get set }
    func register(email: String, password: String, password_confirm: String)
}
protocol RegistrationDelegate: AnyObject {
    func didSucceed(withData data: RegisterResponse)
    func didFail(withError error: Error)
}
struct RegisterResponse {
    let userId: String
    let email: String
}

class RegistrationViewModel: RegistrationProtocol {
    weak var delegate: RegistrationDelegate?

    func register(email: String, password: String, password_confirm: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.delegate?.didFail(withError: error)
                return
            }

            guard let user = authResult?.user else {
                self?.delegate?.didFail(withError: NSError(domain: "Registration", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get user data"]))
                return
            }

            let response = RegisterResponse(userId: user.uid, email: user.email ?? "")
            self?.delegate?.didSucceed(withData: response)
        }
    }
}
