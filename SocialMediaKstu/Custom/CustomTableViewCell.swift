//
//  CustomTableViewCell.swift
//  SocialMediaKstu
//
//  Created by Interlink on 23/12/24.
//

import UIKit
import SnapKit
// MARK: - Custom TableView Cell
class CustomTableViewCell: UITableViewCell {
     let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

     let detailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(emailLabel)
        contentView.addSubview(detailLabel)
        backgroundColor = .white
        emailLabel.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(10)
                    make.left.right.equalToSuperview().inset(20)
                }
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
                    make.left.right.equalToSuperview().inset(20)
                }
      
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with stat: StatisticsViewModel.UserStatistics) {
        emailLabel.text = stat.email
        detailLabel.text = "\(stat.correctAnswers) правильных ответов"
    }
}
