//
//  Auth.swift
//  SocialMediaKstu
//
//  Created by Interlink on 4/12/24.
//
struct ProfileModel {
    let gender: String
    let age: Int
}

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel {
    private let db = Firestore.firestore()
    
    var email: String?

    func fetchUserEmail(completion: @escaping (String?) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            completion(currentUser.email)
        } else {
            completion(nil)
        }
    }

    func saveProfileData(gender: String, birthDate: Date, completion: @escaping (Bool) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }

        let age = calculateAge(from: birthDate)

        let data: [String: Any] = [
            "gender": gender,
            "age": age,
            "birthDate": Timestamp(date: birthDate) // Firestore поддерживает тип Timestamp

        ]

        db.collection("users").document(userId).setData(data, merge: true) { error in
            if let error = error {
                print("Error saving profile: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }

    private func calculateAge(from date: Date) -> Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
        return ageComponents.year ?? 0
    }
}
