//
//  RegistrationView.swift
//  SocialMediaKstu
//
//  Created by Interlink on 18/12/24.
//
import Foundation
import UIKit
import SnapKit

class RegistrationView: UIView {
    
    // MARK: - UI COMPONENTS
  lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.layer.cornerRadius = 23
        button.backgroundColor = UIColor.colorGrey
        button.titleLabel?.font = UIFont(name: "tilda-sans_bold", size: 16)
        
        return button
    }()
    
    // Login Text Field
   lazy var loginTextField: AnimatedTextField = {
        let textField = AnimatedTextField()
        textField.placeholder = "Почта"
       textField.textColor = .black

       let lineView = UIView()
       textField.addSubview(lineView)
       lineView.snp.makeConstraints { make in
           make.height.equalTo(1)
           make.leading.bottom.trailing.equalToSuperview()
       }
        return textField
    }()
    
    
     lazy var passwordTextField: AnimatedTextField = {
        let textField = AnimatedTextField()
        textField.placeholder = "Пароль"
         textField.textColor = .black

         let lineView = UIView()
         textField.addSubview(lineView)
         lineView.snp.makeConstraints { make in
             make.height.equalTo(1)
             make.leading.bottom.trailing.equalToSuperview()
         }
        return textField
    }()
    lazy var repeatpasswordTextField: AnimatedTextField = {
       let textField = AnimatedTextField()
       textField.placeholder = "Повторите Пароль"
        textField.textColor = .black

       let lineView = UIView()
       lineView.backgroundColor = UIColor.colorGrey
       return textField
   }()
  
    lazy var passwordReq: UILabel = {
        let label = UILabel()
        label.text = "At least - 8 symbols.\n To ensure security, a password \nneeds to have both letters and digits."
        label.font = UIFont(name: "tilda-sans", size: 16)
        label.textColor = UIColor.colorGrey
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    lazy var passwordError: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "Passwords don't match"
        label.textColor = UIColor.сolorRed
        label.isHidden = true
        label.textAlignment = .center
        return label
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    private func setUI(){
        addSubview(passwordError)
        addSubview(registrationButton)
        addSubview(repeatpasswordTextField)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(passwordReq)

        
        loginTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(293)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(35)
            
        }
       
        passwordTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(379)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(35)

        }
        repeatpasswordTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(442)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(35)
        }

        registrationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(524)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
      
        passwordError.snp.makeConstraints { make in
            make.top.equalTo(repeatpasswordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        /*passwordReq.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(repeatpasswordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }*/
        
    }
    
    
}
