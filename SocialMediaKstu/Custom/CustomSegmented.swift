//
//  CustomSegmented.swift
//  SocialMediaKstu
//
//  Created by Interlink on 19/12/24.
//

import UIKit

class CustomSegmented: UISegmentedControl {

    enum Gender : String,CaseIterable{
        case male = "Male"
        case female = "Female"
        
        
        init?(rawValue: String) {
                switch rawValue {
                case "Male":
                    self = .male
                case "Female":
                    self = .female
                default:
                    return nil
                }
            }
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    

}
