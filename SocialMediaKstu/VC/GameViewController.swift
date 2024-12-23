//
//  ViewController.swift
//  SocialMediaKstu
//
//  Created by Interlink on 2/12/24.
//

import UIKit
import SnapKit

class GameViewController: UIViewController {
    private let viewModel = GameViewModel()
    private let gameView = GameView()

    override func loadView() {
        view = gameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        updateUI()
    }

    private func setupActions() {
        gameView.answer1Button.addTarget(self, action: #selector(answer1Tapped), for: .touchUpInside)
        gameView.answer2Button.addTarget(self, action: #selector(answer2Tapped), for: .touchUpInside)
        gameView.answer3Button.addTarget(self, action: #selector(answer3Tapped), for: .touchUpInside)
        gameView.answer4Button.addTarget(self, action: #selector(answer4Tapped), for: .touchUpInside)
    }

    private func updateUI() {
        guard !viewModel.isGameOver else {
            showGameOver()
            return
        }

        let word = viewModel.currentWord
        gameView.wordLabel.text = word.label
        gameView.answer1Button.setTitle(word.options[0], for: .normal)
        gameView.answer2Button.setTitle(word.options[1], for: .normal)
        gameView.answer3Button.setTitle(word.options[2], for: .normal)
        gameView.answer4Button.setTitle(word.options[3], for: .normal)

        for button in [gameView.answer1Button, gameView.answer2Button, gameView.answer3Button, gameView.answer4Button] {
            button.backgroundColor = .systemGray5
        }
        gameView.feedbackLabel.text = ""
    }

    private func showGameOver() {
        let resultVC = ResultGameController()
        resultVC.correctAnswers = viewModel.correctAnswers
        resultVC.totalMistakes = viewModel.totalMistakes
        navigationController?.pushViewController(resultVC, animated: true)
    }

    private func restartGame() {
        viewModel.resetGame()
        updateUI()
    }

    @objc private func answer1Tapped() {
        handleAnswer(gameView.answer1Button.title(for: .normal))
    }

    @objc private func answer2Tapped() {
        handleAnswer(gameView.answer2Button.title(for: .normal))
    }

    @objc private func answer3Tapped() {
        handleAnswer(gameView.answer3Button.title(for: .normal))
    }

    @objc private func answer4Tapped() {
        handleAnswer(gameView.answer4Button.title(for: .normal))
    }

    private func handleAnswer(_ answer: String?) {
        guard let answer = answer else { return }

        let isCorrect = viewModel.checkAnswer(answer)
        if isCorrect {
            gameView.feedbackLabel.text = "Правильно!"
            gameView.feedbackLabel.textColor = .green
        } else {
            gameView.feedbackLabel.text = "Ошибка. Правильный ответ: \(viewModel.currentWord.correctAnswer)"
            gameView.feedbackLabel.textColor = .red
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.updateUI()
        }
    }
}