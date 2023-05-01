//
//  ContentView.swift
//  Demo_mvvm
//
//  Created by Артем Романов on 25.04.2023.
//

import SwiftUI

struct TabBarView<ViewModel>: View where ViewModel: TabViewModelProtocol {
    
    @State private var selectedTab: Tab = .login
    
    @StateObject var viewModel: ViewModel
    
    // MARK: - Body
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(viewModel.tabs, id: \.id) {
                createScreen($0)
            }
        }
    }
    
    // MARK: - Private methods
    
    @ViewBuilder
    private func createScreen(_ screen: Tab) -> some View {
        switch screen {
        case .login:
            LoginScreen(viewModel: LoginViewModel())
                .tabItem {
                    createTabItem(with: screen.rawValue)
                }
                .tag(screen.rawValue)
        case .profile:
            ProfileScreen(viewModel: ProfileViewModel())
                .tabItem {
                    createTabItem(with: screen.rawValue)
                }
                .tag(screen.rawValue)
        }
    }
    
    private func createTabItem(with text: String) -> some View {
        VStack {
            Text(text.capitalized)
                .font(.caption)
        }
    }
    
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(viewModel: TabViewModel())
    }
}
