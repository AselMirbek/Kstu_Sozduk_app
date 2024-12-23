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
        label.textAlignment = .center
        return label
    }()
    
     let genderSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Male", "Female", "Other"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
     let birthDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
     let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.colorBlue
        button.setTitle("Save", for: .normal)
        button.layer.cornerRadius = 23
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
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
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
}
        genderSegmentedControl.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(250)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
}
        birthDatePicker.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(270)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
}
            saveButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(379)
                make.height.equalTo(70)
                make.width.equalTo(70)

            }
        }
        
    }

