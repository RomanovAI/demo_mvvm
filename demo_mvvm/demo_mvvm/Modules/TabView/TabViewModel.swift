//
//  TabViewModel.swift
//  Demo_mvvm
//
//  Created by Артем Романов on 26.04.2023.
//

import Foundation

protocol TabViewModelProtocol: ObservableObject {
    var selectedTab: Tab { get set }
    var tabs: [Tab] { get }
}

final class TabViewModel: TabViewModelProtocol {
    
    @Published var selectedTab: Tab = .login
    
    var tabs: [Tab] {
        [.login, .profile]
    }
    
}
