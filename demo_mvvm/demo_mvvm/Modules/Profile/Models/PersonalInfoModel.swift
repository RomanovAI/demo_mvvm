//
//  PersonalInfoModel.swift
//  Demo_mvvm
//
//  Created by Артем Романов on 28.04.2023.
//

import Foundation

struct PersonalInfoModel: Hashable {
    
    enum InfoType {
        case phone
        case email
    }
    
    let title: String
    let iconName: String
    var subtitle: String?
    
    init(infoType: InfoType) {
        switch infoType {
        case .phone:
            self.title = "Phone number"
            self.iconName = "icPhone"
        case .email:
            self.title = "Email"
            self.iconName = "icMail"
        }
    }
}
