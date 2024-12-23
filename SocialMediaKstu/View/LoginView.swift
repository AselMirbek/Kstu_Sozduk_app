//
//  LoginView.swift
//  SocialMediaKstu
//
//  Created by Interlink on 18/12/24.
//

import Foundation
import UIKit
import SnapKit

class LoginView: UIView {
    
    // MARK: - UI COMPONENTS
  lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 23
        button.backgroundColor = UIColor.colorGrey
        button.titleLabel?.font = UIFont(name: "tilda-sans_bold", size: 16)
        
        return button
    }()
    
  lazy var registrationToNextTappedButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "tilda-sans_medium", size: 14)
        button.setTitle("Зарегистрироваться", for: .normal)
      button.setTitleColor(UIColor.colorBlue, for: .normal)

        return button
    }()

    // Login Text Field
   lazy var loginTextField: AnimatedTextField = {
        let textField = AnimatedTextField()
        textField.placeholder = "Почта"
       textField.textColor = .black
       let lineView = UIView()
       lineView.backgroundColor = UIColor.colorGrey
        return textField
    }()
    lazy var nameLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorGrey
        return view
    }()
    
    
     lazy var passwordTextField: AnimatedTextField = {
        let textField = AnimatedTextField()
        textField.placeholder = "Пароль"
         textField.textColor = .black
         textField.isSecureTextEntry = true

         let button = UIButton(type: .custom)
         button.configuration = .plain() // Use UIButtonConfiguration
         button.configuration?.imagePadding = 16 // Adjust image padding
         button.setImage(UIImage(named: "eye-disabled"), for: .normal)
         button.setImage(UIImage(named: "eye"), for: .selected)
         button.frame = CGRect(x: textField.frame.size.width - 25, y: 5, width: 25, height: 25)
 //        button.addTarget(LoginView.self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
         textField.rightView = button
         textField.rightViewMode = .always
         return textField}()
    lazy var passwordLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorGrey
        return view
    }()
    
    lazy var statusLabel: UIView = {
        let view = UIView()
        let label = UILabel()
        let imageView = UIImageView()
        label.text = "Неправильно логин или пароль"
        label.font = UIFont(name: "tilda-sans_medium", size: 16)
        label.textColor = .white
        imageView.image = UIImage(named: "внимание")
        
        view.addSubview(label)
        view.addSubview(imageView)
        view.backgroundColor = UIColor.сolorRed
        view.isHidden = true
        view.layer.cornerRadius = 16
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.trailing.equalTo(label.snp.leading).inset(-6)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        return view
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
        addSubview(loginButton)
        addSubview(registrationToNextTappedButton)
        addSubview(nameLine)
        addSubview(passwordLine)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(statusLabel)

        
        loginTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(293)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(35)
            
        }
        nameLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(loginTextField.snp.leading)
            make.trailing.equalTo(loginTextField.snp.trailing)
            make.bottom.equalTo(loginTextField.snp.bottom)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(379)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(35)

        }
        passwordLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.bottom.equalTo(passwordTextField.snp.bottom)
        }

        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(497)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
       
        registrationToNextTappedButton.snp.makeConstraints{
            make in
            make.top.equalToSuperview().inset(737.5)
            make.leading.equalToSuperview().inset(112.5)
            make.trailing.equalToSuperview().inset(112.5)
        } 
        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.leading.equalToSuperview().inset(28)
            make.trailing.equalToSuperview().inset(28)
        }
        
        
    }
    
    
}
