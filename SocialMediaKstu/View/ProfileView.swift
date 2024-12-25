//
//  ProfileView.swift
//  SocialMediaKstu
//
//  Created by Interlink on 19/12/24.
//

import UIKit

class ProfileView: UIView {
    // MARK: - UI COMPONENTS
    
    lazy var emailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Tilda Sans Bold", size: 24)
        label.text = "Почта:"
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    

    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Tilda Sans Medium", size: 20)
        label.textColor = .label
        label.textColor = .black
        label.textAlignment = .left

        return label
    }()
    lazy var genderTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Tilda Sans Bold", size: 24)
        label.text = "Выберите ваш пол:"
        label.textColor = .darkGray
        label.textAlignment = .left

        return label
    }()
    
     let genderSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Мужчина", "Женщина"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
         segmentedControl.tintColor = .systemBlue

        return segmentedControl
    }()
    lazy var birthTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Tilda Sans Bold", size: 24)
        label.text = "Выберите дату рождения:"
        label.textColor = .darkGray
        label.textAlignment = .left

        return label
    }()
    
     let birthDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.translatesAutoresizingMaskIntoConstraints = false
         datePicker.tintColor = .systemBlue

        return datePicker
    }()
    
     let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.colorBlue
        button.setTitle("Сохранить", for: .normal)
        button.layer.cornerRadius = 23
        button.titleLabel?.font = UIFont(name: "Tilda Sans Bold", size: 16)
         button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                button.tintColor = .white
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        return button
    }()
    

    lazy var logOutButton: UIButton = {
          let button = UIButton()
          button.titleLabel?.font = UIFont(name: "Tilda Sans Medium", size: 20)
          button.setTitle("Выйти с аккаунта", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
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
        backgroundColor = UIColor.colorBackground
        setupViews()
    }
    
    // MARK: - UI SETUP
    
    
    func setupViews() {
        addSubview(genderTitleLabel)
        addSubview(birthTitleLabel)
        addSubview(emailTitleLabel)
        addSubview(emailLabel)
        addSubview(genderSegmentedControl)
        addSubview(birthDatePicker)
        addSubview(saveButton)
        addSubview(logOutButton)
        emailTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.leading.equalToSuperview().inset(20)
            //make.trailing.equalToSuperview().inset(20)
}
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
           // make.trailing.equalToSuperview().inset(20)
}
        genderTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            //make.trailing.equalToSuperview().inset(20)
}
        genderSegmentedControl.snp.makeConstraints{ make in
            make.top.equalTo(genderTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(120)
}
        birthTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(genderSegmentedControl.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
           // make.trailing.equalToSuperview().inset(20)
}
        birthDatePicker.snp.makeConstraints{ make in
            make.top.equalTo(birthTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(200)
}
            saveButton.snp.makeConstraints { make in
                make.top.equalTo(birthDatePicker.snp.bottom).offset(40)
                make.height.equalTo(50)
                make.width.equalTo(150)
                make.trailing.equalToSuperview().inset(20)

            }
        logOutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(600)
            make.height.equalTo(70)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()

        }
       
        }
        
    }

