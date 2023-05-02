//
//  LoginViewModel.swift
//  Demo_mvvm
//
//  Created by Артем Романов on 26.04.2023.
//

import Foundation

protocol LoginViewModelProtocol: AnyObject, ObservableObject {
    
    var login: String { get set }
    var password: String { get set }
    var alertModel: AlertModel { get }
    var alertIsPresented: Bool { get set }
    var isAvailableButton: Bool { get }
    
    func buttonTapped()
    func alertActionTapped()
    
}

final class LoginViewModel: LoginViewModelProtocol {
    
    // MARK: - Public properties
    
    @Published var login: String = .init()
    @Published var password: String = .init()
    @Published var alertIsPresented: Bool = false
    
    var errorText: String = .init()
    var alertModel = AlertModel(title: "Error")
    
    var isAvailableButton: Bool {
        !login.isEmpty && !password.isEmpty
    }
    
    var credentialsAreValid: Bool {
        errorText.isEmpty
    }
    
    // MARK: - Public methods
    
    func buttonTapped() {
        validate()
        
        if credentialsAreValid {
            goNext()
        } else {
            showAlert()
        }
    }
    
    func alertActionTapped() {
        errorText = .init()
        alertIsPresented = false
    }
    
    // MARK: - Private methods
    
    private func validate() {
        if login != DefaultCredentials.successLogin {
            errorText = "Incorrect login"
        }
        
        if password != DefaultCredentials.successPassword {
            errorText += "\nIncorrect password"
        }
    }
    
    private func goNext() {}
    
    private func showAlert() {
        alertModel.message = errorText
        alertIsPresented = true
    }
    
}

