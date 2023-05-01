//
//  Demo_mvvmApp.swift
//  Demo_mvvm
//
//  Created by Артем Романов on 26.04.2023.
//

import SwiftUI

@main
struct Demo_mvvmApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabBarView(viewModel: TabViewModel())
        }
    }
    
}
