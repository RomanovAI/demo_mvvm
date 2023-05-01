//
//  LoginScreen.swift
//  Demo_mvvm
//
//  Created by Артем Романов on 26.04.2023.
//

import SwiftUI

struct LoginScreen<ViewModel>: View where ViewModel: LoginViewModelProtocol {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            image
            
            login
            
            password
            
            Spacer()
            
            button
            
        }
        .alert(
            viewModel.alertModel.title,
            isPresented: $viewModel.alertIsPresented) {
                Button(viewModel.alertModel.buttonTitle) {
                    viewModel.alertActionTapped()
                }
            } message: {
                Text(viewModel.alertModel.message)
            }
            .defaultPadding()
    }
    
    // MARK: - Image
    
    private var image: some View {
        Image("imgLogin")
            .resizable()
            .frame(width: 200, height: 200)
    }
    
    // MARK: - Login
    
    private var login: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Login")
                .font(.headline)
                .foregroundColor(.black)
            
            StandardTextField(
                placeholder: DefaultCredentials.successLogin,
                text: $viewModel.login
            )
        }
    }
    
    // MARK: - Password
    private var password: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Password")
                .font(.headline)
                .foregroundColor(.black)
            
            StandardTextField(
                placeholder: DefaultCredentials.successPassword,
                text: $viewModel.password
            )
        }
    }
    
    // MARK: - Button
    
    private var button: some View {
        StandardButton(
            text: "Login",
            isAvailable: viewModel.isAvailableButton
        ) {
            viewModel.buttonTapped()
        }
        .disabled(!viewModel.isAvailableButton)
    }
    
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(viewModel: LoginViewModel())
    }
}

