//
//  ProfileService.swift
//  Demo
//
//  Created by Артем Романов on 22.03.2023.
//

protocol ProfileServiceProtocol {
    func getProfileInfo() async throws  -> ProfileResponseModel
}

struct ProfileService: ProfileServiceProtocol {
    
    func getProfileInfo() async throws -> ProfileResponseModel {
        let time: UInt64 = Bool.random() ? 1_000_000_000 : 3_000_000_000
        try? await Task.sleep(nanoseconds: time)
        return .init(
            id: "32357872",
            firstName: "John",
            lastName: "Doe",
            phone: "79156654321",
            email: "JohnDoe@gmail.com"
        )
    }
    
}
