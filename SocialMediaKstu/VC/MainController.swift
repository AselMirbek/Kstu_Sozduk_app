//
//  MainController.swift
//  SocialMediaKstu
//
//  Created by Interlink on 4/12/24.
//

import Foundation
import UIKit
import SnapKit
class MainController :UIViewController {
    private let mainView = MainView()
    override func loadView() {
           view = mainView
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func addTargets() {
        mainView.startgameButton.addTarget(self, action: #selector(gameStartPressed), for: .touchUpInside)
        mainView.instruksiaButton.addTarget(self, action: #selector(instruksiaRead), for: .touchUpInside)
        mainView.historyButton.addTarget(self, action: #selector(historyGame), for: .touchUpInside)
    }
 
        @objc func gameStartPressed() {
           let vc = GameViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    @objc func instruksiaRead() {
        let vc = DocumentController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func historyGame() {
        let vc = HistoryController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
            
}
