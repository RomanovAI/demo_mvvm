//
//  LoginViewModelTests.swift
//  LoginViewModelTests
//
//  Created by Артем Романов on 02.05.2023.
//

import XCTest
@testable import Demo_mvvm

final class LoginViewModelTests: XCTestCase {
    
    var loginViewModel: LoginViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        loginViewModel = LoginViewModel()
    }
    
    override func tearDownWithError() throws {
        loginViewModel = nil
        try super.tearDownWithError()
    }
    
    func testSuccessCredentials() {
        loginViewModel.login = "User"
        loginViewModel.password = "123"
        
        loginViewModel.buttonTapped()
        
        XCTAssertTrue(loginViewModel.credentialsAreValid)
    }

    func testSuccessIsAvailableButton() {
        loginViewModel.login = "U"
        loginViewModel.password = "1"
        
        XCTAssertTrue(loginViewModel.isAvailableButton)
    }
    
    func testSuccessIsNotAvailableButton() {
        loginViewModel.login = ""
        loginViewModel.password = ""
        
        XCTAssertFalse(loginViewModel.isAvailableButton)
    }
    
    func testShowAlert() {
        let error =
            """
            Incorrect login
            Incorrect password
            """
        
        loginViewModel.buttonTapped()

        XCTAssertTrue(loginViewModel.alertIsPresented)
        XCTAssertEqual(loginViewModel.errorText, error)
        
    }
    
}
