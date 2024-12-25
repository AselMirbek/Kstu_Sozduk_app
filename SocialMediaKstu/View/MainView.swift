//
//  MainView.swift
//  SocialMediaKstu
//
//  Created by Interlink on 19/12/24.
//

import Foundation
import UIKit

class MainView: UIView {
    lazy var startgameButton: UIButton = {
          let button = UIButton()
          button.layer.cornerRadius = 23
          button.backgroundColor = UIColor.colorBlue
          button.setTitle("Начать игру", for: .normal)
         button.setTitleColor(.white, for: .normal)
          button.titleLabel?.font = UIFont(name: "Tilda Sans Bold", size: 16)
          
          return button
      }()
    lazy var historyButton: UIButton = {
          let button = UIButton()
          button.layer.cornerRadius = 23
        button.setTitle("История", for: .normal)
        button.setTitleColor(.white, for: .normal)

          button.backgroundColor = UIColor.colorBlue
          button.titleLabel?.font = UIFont(name: "Tilda Sans Bold", size: 16)
          
          return button
      }()
    lazy var instruksiaButton: UIButton = {
          let button = UIButton()
          button.layer.cornerRadius = 23
          button.setTitle("Правила игры", for: .normal)
        button.setTitleColor(.white, for: .normal)

          button.backgroundColor = UIColor.colorBlue
          button.titleLabel?.font = UIFont(name: "Tilda Sans Bold", size: 16)
          
          return button
      }()
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.setUI()
        self.backgroundColor = UIColor.white
    }
    private func setUI(){
        addSubview(startgameButton)
        addSubview(instruksiaButton)
        addSubview(historyButton)
        startgameButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(274)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(150)
            
        }
        instruksiaButton.snp.makeConstraints { make in
            make.top.equalTo(startgameButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(150)
            
        }
        historyButton.snp.makeConstraints { make in
            make.top.equalTo(instruksiaButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(150)
            
        }
    }
}
