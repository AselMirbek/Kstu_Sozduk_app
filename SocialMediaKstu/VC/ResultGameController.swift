//
//  ResultController.swift
//  SocialMediaKstu
//
//  Created by Interlink on 19/12/24.
//

import UIKit
import SnapKit
class ResultGameController: UIViewController {
    var correctAnswers: Int = 0
    var totalMistakes: Int = 0

    private let resultLabel = UILabel()
    private let playAgainButton = UIButton(type: .system)
    private let viewModel = GameViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayResults()
        saveGameHistory()
    }

    private func setupUI() {
        view.backgroundColor = .white

        // Result Label
        resultLabel.font = .systemFont(ofSize: 24, weight: .bold)
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        resultLabel.textColor = .black
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }

        // Play Again Button
        playAgainButton.setTitle("Играть снова", for: .normal)
        playAgainButton.titleLabel?.font = .systemFont(ofSize: 18)
        playAgainButton.addTarget(self, action: #selector(playAgainTapped), for: .touchUpInside)
        view.addSubview(playAgainButton)
        playAgainButton.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    private func displayResults() {
        resultLabel.text = """
        Игра окончена!
        Правильных ответов: \(correctAnswers)
        Ошибок: \(totalMistakes)
        """
    }

    @objc private func playAgainTapped() {
        navigationController?.popViewController(animated: true)
    }
    private func saveGameHistory() {
            viewModel.saveGameHistory(correctAnswers: correctAnswers, totalMistakes: totalMistakes)
        }
}
