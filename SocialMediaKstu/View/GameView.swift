//
//  GameView.swift
//  SocialMediaKstu
//
//  Created by Interlink on 19/12/24.
//

import Foundation
import UIKit

class GameView: UIView {
    // MARK: - UI COMPONENTS
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "Tilda Sans Bold", size: 18)
        label.textAlignment = .center
        return label
    }()
    lazy var wordLabel : UILabel = {
        let label = UILabel()
        label.textColor = .brown
        label.font = UIFont(name: "Tilda Sans Bold", size: 35)
        label.textAlignment = .center

        return label
    }()
    lazy var feedbackLabel : UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "tilda-sans_bold", size: 18)
        label.textAlignment = .center
        return label
    }()
  lazy var answer1Button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 23
        button.backgroundColor = UIColor.systemBrown
        button.titleLabel?.font = UIFont(name: "Tilda Sans Bold", size: 18)
        
        return button
    }()
    lazy var answer2Button: UIButton = {
          let button = UIButton()
          button.layer.cornerRadius = 23
          button.backgroundColor = UIColor.colorGrey
          button.titleLabel?.font = UIFont(name: "Tilda Sans Bold", size: 18)
          
          return button
      }()
    lazy var answer3Button: UIButton = {
          let button = UIButton()
          button.layer.cornerRadius = 23
          button.backgroundColor = UIColor.colorGrey
          button.titleLabel?.font = UIFont(name: "Tilda Sans Bold", size: 18)
          
          return button
      }() 
    lazy var answer4Button: UIButton = {
          let button = UIButton()
          button.layer.cornerRadius = 23
          button.backgroundColor = UIColor.colorGrey
          button.titleLabel?.font = UIFont(name: "Tilda Sans Bold", size: 18)
          
          return button
      }()


    override init(frame: CGRect) {
           super.init(frame: frame)
           setupUI()
       }
    
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    private  func setupUI(){
        backgroundColor = .white
        addSubview(wordLabel)
        addSubview(feedbackLabel)
        addSubview(answer1Button)
        addSubview(answer2Button)
        addSubview(answer3Button)
        addSubview(answer4Button)
        addSubview(progressLabel)
        wordLabel.snp.makeConstraints { make in
                   make.top.equalTo(safeAreaLayoutGuide).offset(50)
                   make.centerX.equalToSuperview()
               }
        // Buttons grid
                let gridStack = UIStackView()
                gridStack.axis = .vertical
                gridStack.spacing = 16
                gridStack.distribution = .fillEqually

                let row1 = UIStackView(arrangedSubviews: [answer1Button, answer2Button])
                row1.axis = .horizontal
                row1.spacing = 16
                row1.distribution = .fillEqually

                let row2 = UIStackView(arrangedSubviews: [answer3Button, answer4Button])
                row2.axis = .horizontal
                row2.spacing = 16
                row2.distribution = .fillEqually

                gridStack.addArrangedSubview(row1)
                gridStack.addArrangedSubview(row2)
        addSubview(gridStack)
        gridStack.snp.makeConstraints { make in
                    make.top.equalTo(progressLabel.snp.bottom).offset(30)
                    make.left.right.equalToSuperview().inset(20)
                    make.height.equalTo(200)
                }
        // Feedback label

               feedbackLabel.snp.makeConstraints { make in
                   make.top.equalTo(gridStack.snp.bottom).offset(20)
                   make.centerX.equalToSuperview()
               }
           progressLabel.snp.makeConstraints { make in
                  make.top.equalTo(wordLabel.snp.bottom).offset(10)
                  make.centerX.equalToSuperview()
              }


    }
}
