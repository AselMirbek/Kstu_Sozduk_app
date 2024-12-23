//
//  File.swift
//  SocialMediaKstu
//
//  Created by Interlink on 20/12/24.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore

// MARK: - Model
struct Word {
    let label: String
    let options: [String]
    let correctAnswer: String
}

struct GameHistoryItem {
    var correctAnswers: Int
       var totalMistakes: Int
       var date: String // Формат: "MM/dd/yyyy, HH:mm"
    init(correctAnswers: Int, totalMistakes: Int, date: String) {
            self.correctAnswers = correctAnswers
            self.totalMistakes = totalMistakes
            self.date = date
        }
        
        // Преобразование в словарь для сохранения в Firestore
    func toDictionary() -> [String: Any] {
        return [
            "correctAnswers": correctAnswers,
            "totalMistakes": totalMistakes,
            "date": date
        ]
    }
}

// MARK: - ViewModel
class GameViewModel {
    private let firestore = Firestore.firestore()

    // Список слов для игры
    private let words: [Word] = [
        Word(label: "Алма", options: ["Яблоко", "Груша", "Банан", "Апельсин"], correctAnswer: "Яблоко"),
        Word(label: "Ит", options: ["Собака", "Кошка", "Лошадь", "Мышь"], correctAnswer: "Собака"),
        Word(label: "Китеп", options: ["Книга", "Журнал", "Тетрадь", "Газета"], correctAnswer: "Книга"),
        Word(label: "Үй", options: ["Дом", "Квартира", "Комната", "Офис"], correctAnswer: "Дом"),
        Word(label: "Эне", options: ["Бабушка", "Сестра", "Отец", "Мать"], correctAnswer: "Мать"),
        Word(label: "Мектеп", options: ["Собака", "Кружка", "Школа", "Университет"], correctAnswer: "Школа"),
        Word(label: "Теңиз", options: ["Море", "Река", "Озеро", "Бассейн"], correctAnswer: "Стол"),
        Word(label: "Күн", options: ["Звезда", "Море", "Солнце", "Луна"], correctAnswer: "Солнце"),
        Word(label: "Баш", options: ["Голова", "Язык", "Рука", "Нога"], correctAnswer: "Голова"),
        Word(label: "Тоо", options: ["Гора", "Лавина", "Язык", "Холм"], correctAnswer: "Гора"),
    ]
    
    // Индекс текущего слова
    private(set) var currentWordIndex = 0
    
    // Количество правильных ответов
    private(set) var correctAnswers = 0
    
    // Общее количество ошибок
    private(set) var totalMistakes = 0
    
    // Текущий вопрос
    var currentWord: Word {
        guard currentWordIndex < words.count else {
            fatalError("Игра завершена: попытка доступа к несуществующему слову.")
        }
        return words[currentWordIndex]    }
    
    // Проверка, закончилась ли игра
    var isGameOver: Bool {
        currentWordIndex >= words.count - 1
    }
    
    
    
    // Проверить ответ пользователя
    func checkAnswer(_ answer: String) -> Bool {
        guard !isGameOver else {
            print("Игра завершена. Невозможно проверить ответ.")
            return false
        }
        let isCorrect = answer == currentWord.correctAnswer
        if isCorrect {
            correctAnswers += 1
        } else {
            totalMistakes += 1
        }
        advanceToNextWord()
        return isCorrect
    }
    
    func advanceToNextWord() {
        if currentWordIndex < words.count - 1 {
            currentWordIndex += 1
        }
    }
    
    // Сброс игры
    func resetGame() {
        currentWordIndex = 0
        correctAnswers = 0
        totalMistakes = 0
    }
    // Сохранение истории игры в Firestore
    func saveGameHistory(correctAnswers: Int, totalMistakes: Int) {
           let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)
           let historyItem: [String: Any] = [
               "correctAnswers": correctAnswers,
               "totalMistakes": totalMistakes,
               "date": date
           ]
           
           firestore.collection("gameHistory").addDocument(data: historyItem) { error in
               if let error = error {
                   print("Ошибка при сохранении истории игры: \(error.localizedDescription)")
               } else {
                   print("История игры успешно сохранена.")
               }
           }
       }
    // Завершение игры
    func endGame() {
        // Передаем правильные ответы и количество ошибок в метод сохранения
        saveGameHistory(correctAnswers: correctAnswers, totalMistakes: totalMistakes)
        resetGame()
    }
    // Получение истории игр из Firestore
    func fetchGameHistory(completion: @escaping ([GameHistoryItem]) -> Void) {
           firestore.collection("gameHistory").getDocuments { snapshot, error in
               if let error = error {
                   print("Ошибка при загрузке истории игр: \(error.localizedDescription)")
                   return
               }
               
               var historyItems: [GameHistoryItem] = []
               for document in snapshot?.documents ?? [] {
                   if let correctAnswers = document["correctAnswers"] as? Int,
                      let totalMistakes = document["totalMistakes"] as? Int,
                      let date = document["date"] as? String {
                       let item = GameHistoryItem(correctAnswers: correctAnswers, totalMistakes: totalMistakes, date: date)
                       historyItems.append(item)
                   }
               }
               completion(historyItems)
           }
       }}
