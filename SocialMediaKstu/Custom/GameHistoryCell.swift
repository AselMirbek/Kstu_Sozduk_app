//
//  GameHistoryCell.swift
//  SocialMediaKstu
//
//  Created by Interlink on 26/12/24.
//

import Foundation
import UIKit
import SnapKit
// MARK: - Custom UITableViewCell
class GameHistoryCell: UITableViewCell {
    static let identifier = "GameHistoryCell"
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let correctLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemGreen
        return label
    }()
    
    private let mistakesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemRed
        return label
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.yellow.cgColor
        view.backgroundColor = UIColor.yellow.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(dateLabel)
        contentView.addSubview(correctLabel)
        contentView.addSubview(mistakesLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupConstraints() {
     
            dateLabel.snp.makeConstraints { make in
                make.top.left.equalToSuperview().inset(5)
                make.trailing.equalToSuperview().inset(20)
            }
            
            correctLabel.snp.makeConstraints { make in
                make.top.equalTo(dateLabel.snp.bottom).offset(5)
                make.leading.equalToSuperview().inset(20)
            }
            
            mistakesLabel.snp.makeConstraints { make in
                make.top.equalTo(correctLabel)
                make.leading.equalTo(correctLabel.snp.trailing).offset(20)
            }
        }
    func configure(with item: GameHistoryItem) {
        dateLabel.text = "Дата: \(item.date)"
        correctLabel.text = "Правильно: \(item.correctAnswers)"
        mistakesLabel.text = "Ошибки: \(item.totalMistakes)"
    }
}
