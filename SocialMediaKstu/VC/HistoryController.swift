//
//  HistoryController.swift
//  SocialMediaKstu
//
//  Created by Interlink on 19/12/24.
//

import UIKit
import FirebaseFirestore

class HistoryController: UIViewController {
    // MARK: - Properties
    private let viewModel = GameViewModel()
    private var gameHistory: [GameHistoryItem] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchHistory()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
    }
    
    // MARK: - Fetch Data
    private func fetchHistory() {
        viewModel.fetchGameHistory { [weak self] history in
            DispatchQueue.main.async {
                self?.gameHistory = history.sorted { $0.date > $1.date } // Сортируем по дате
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension HistoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let historyItem = gameHistory[indexPath.row]
        cell.textLabel?.text = "Date: \(historyItem.date) | Correct: \(historyItem.correctAnswers) | Mistakes: \(historyItem.totalMistakes)"
        return cell
    }
}
