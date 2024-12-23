//
//  DocumentController.swift
//  SocialMediaKstu
//
//  Created by Interlink on 19/12/24.
//

import UIKit
import WebKit

class DocumentController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomNavigationBar(title: "Правила", backButtonAction: #selector(backPressed))

        // Создаем конфигурацию WKWebView
        let webViewConfiguration = WKWebViewConfiguration()
        
        // Инициализация WKWebView
        webView = WKWebView(frame: self.view.frame, configuration: webViewConfiguration)
        webView.navigationDelegate = self
        self.view.addSubview(webView)

        // Загрузка локального HTML-файла
        if let filePath = Bundle.main.path(forResource: "Rules", ofType: "html") {
            let url = URL(fileURLWithPath: filePath)
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    // Делегат для отслеживания начала загрузки страницы
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Загрузка страницы началась")
    }

    // Делегат для отслеживания ошибок при загрузке
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Ошибка при загрузке: \(error.localizedDescription)")
    }

    // Делегат для отслеживания завершения загрузки
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Загрузка завершена")
    }
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}
