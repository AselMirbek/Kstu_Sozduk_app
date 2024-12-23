import Foundation
import FirebaseFirestore
import FirebaseAuth

class StatisticsViewModel{
    private let db = Firestore.firestore()
    
    struct UserStatistics {
        let email: String
        let correctAnswers: Int
    }
    
    // Метод для получения топ-10 пользователей
    func fetchTopUsers(completion: @escaping ([UserStatistics]) -> Void) {
        db.collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Ошибка при загрузке пользователей: \(error.localizedDescription)")
                completion([])
                return
            }
            
            var userStats: [UserStatistics] = [] // Очищаем массив для новой статистики
            
            let group = DispatchGroup()
            
            snapshot?.documents.forEach { document in
                group.enter()
                let userId = document.documentID
                
                self.db.collection("users")
                    .document(userId)
                    .collection("gameHistory")
                    .getDocuments { gameHistorySnapshot, error in
                        if let error = error {
                            print("Ошибка при загрузке истории для пользователя \(userId): \(error.localizedDescription)")
                            group.leave()
                            return
                        }
                        
                        // Находим максимальное количество правильных ответов из всех игр
                        let maxCorrectAnswers = gameHistorySnapshot?.documents.compactMap { doc -> Int? in
                            return doc["correctAnswers"] as? Int
                        }.max() ?? 0
                        
                        // Получаем email пользователя
                        let email = document["email"] as? String ?? "Неизвестно"
                        
                        // Добавляем статистику в массив, если максимальный балл больше нуля
                        if maxCorrectAnswers > 0 {
                            userStats.append(UserStatistics(email: email, correctAnswers: maxCorrectAnswers))
                        }
                        
                        group.leave()
                    }
            }
            
            group.notify(queue: .main) {
                // Сортируем по максимальному количеству правильных ответов и берем топ-10
                let sortedStats = userStats.sorted { $0.correctAnswers > $1.correctAnswers }
                completion(Array(sortedStats.prefix(10)))
            }
        }
    }
}
