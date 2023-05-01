//
//  Tab.swift
//  Demo_mvvm
//
//  Created by Артем Романов on 28.04.2023.
//

enum Tab: String, Identifiable {
    
    case login
    case profile
    
    var id: String {
        rawValue
    }
    
}
