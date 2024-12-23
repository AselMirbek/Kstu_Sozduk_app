//
//  ProfileView.swift
//  SocialMediaKstu
//
//  Created by Interlink on 19/12/24.
//

import UIKit

class ProfileView: UIView {
    // MARK: - UI COMPONENTS
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .label
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
     let genderSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Мужчина", "Женщина"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
         segmentedControl.tintColor = .systemBlue

        return segmentedControl
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
         button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal) // Иконка на кнопке
                button.tintColor = .white // Белый цвет для иконки
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10) // Корректировка иконки
                button.contentVerticalAlignment = .center
        return button
    }()
    
    let logOutButton: UIButton = {
       let button = UIButton(type: .system)
       button.backgroundColor = UIColor.systemRed
       button.setTitle("Выйти с аккаунта", for: .normal)
       button.layer.cornerRadius = 23
       button.titleLabel?.font = UIFont(name: "Tilda Sans Bold", size: 16)
       button.contentVerticalAlignment = .center
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
        addSubview(emailLabel)
        addSubview(genderSegmentedControl)
        addSubview(birthDatePicker)
        addSubview(saveButton)
        addSubview(logOutButton)
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
}
        genderSegmentedControl.snp.makeConstraints{ make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
}
        birthDatePicker.snp.makeConstraints{ make in
            make.top.equalTo(genderSegmentedControl.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
}
            saveButton.snp.makeConstraints { make in
                make.top.equalTo(birthDatePicker.snp.bottom).offset(40)
                make.height.equalTo(70)
                make.width.equalTo(200)
                make.centerX.equalToSuperview()

            }
        logOutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(500)
            make.height.equalTo(70)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()

        }
       
        }
        
    }

