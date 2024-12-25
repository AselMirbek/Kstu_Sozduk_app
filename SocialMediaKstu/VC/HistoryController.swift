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
           tableView.register(GameHistoryCell.self, forCellReuseIdentifier: GameHistoryCell.identifier)
           tableView.separatorStyle = .none
           tableView.backgroundColor = .white
           return tableView
       }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomNavigationBar(title: "История", backButtonAction: #selector(backPressed))
        setupUI()
        fetchHistory()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
                 make.edges.equalToSuperview() 
             }
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
    @objc func backPressed() {
            navigationController?.popViewController(animated: true)
        }
}

// MARK: - UITableViewDataSource
extension HistoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameHistory.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let cell = tableView.cellForRow(at: indexPath)
           cell?.contentView.backgroundColor = .white
           
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GameHistoryCell.identifier, for: indexPath) as? GameHistoryCell else {
                return UITableViewCell()
            }
            let historyItem = gameHistory[indexPath.row]
            cell.configure(with: historyItem)
            return cell
        }
}
