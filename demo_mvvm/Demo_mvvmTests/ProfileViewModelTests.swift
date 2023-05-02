//
//  ProfileViewModelTests.swift
//  Demo_mvvmTests
//
//  Created by Артем Романов on 02.05.2023.
//

import Foundation

import XCTest
@testable import Demo_mvvm

final class ProfileViewModelTests: XCTestCase {
    
    var profileViewModel: ProfileViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        profileViewModel = ProfileViewModel()
    }
    
    override func tearDownWithError() throws {
        profileViewModel = nil
        try super.tearDownWithError()
    }
    
    func testSuccessfulProfileLoading() async {
        let successResponse: ProfileResponseModel = .init(
            id: "32357872",
            firstName: "John",
            lastName: "Doe",
            phone: "79156654321",
            email: "JohnDoe@gmail.com"
        )
        
        guard let response = try? await profileViewModel.profileService.getProfileInfo() else { XCTFail(); return }
        
        XCTAssertEqual(successResponse, response)
    }
    
    func testFailureProfileLoading() async {
        profileViewModel.profileService = TestProfileService()
        
        let response = try? await profileViewModel.profileService.getProfileInfo()
        XCTAssertNil(response)
    }
    
}

struct TestProfileService: ProfileServiceProtocol {
    func getProfileInfo() async throws -> ProfileResponseModel {
        throw NSError()
    }
}
