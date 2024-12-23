//
//  pod --version ChartViewModel.swift
//  SocialMediaKstu
//
//  Created by Interlink on 23/12/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChartViewModel {
    private let db = Firestore.firestore()
    
    struct UserChart {
        let gender: String
        let age: Int
    }
    
   
    func fetchChart(completion: @escaping ([UserChart]) -> Void) {
            db.collection("users").getDocuments { snapshot, error in
                if let error = error {
                    print("Ошибка при загрузке пользователей: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                var userCharts: [UserChart] = []
                
                // Перебираем документы пользователей
                snapshot?.documents.forEach { document in
                    // Извлекаем данные о поле и возрасте
                    let gender = document["gender"] as? String ?? "Неизвестно"
                    let age = document["age"] as? Int ?? 0
                    
                    // Добавляем в массив, если данные корректны
                    if age > 0 {
                        userCharts.append(UserChart(gender: gender, age: age))
                    }
                }
                
                // Возвращаем массив через completion
                completion(userCharts)
            }
        }
}
