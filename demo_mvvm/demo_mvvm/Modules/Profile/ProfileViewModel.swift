//
//  ProfileViewModel.swift
//  Demo_mvvm
//
//  Created by Артем Романов on 26.04.2023.
//

import Foundation

protocol ProfileViewModelProtocol: ObservableObject {
    
    var loadingState: LoadingState { get }
    var lifetimeId: String { get }
    var isAuthorized: Bool { get }
    var name: String { get }
    var infoModels: [PersonalInfoModel] { get }
    
    var alertModel: AlertModel { get }
    var alertIsPresented: Bool { get set }
    
    var confirmationDialogModel: ConfirmationDialogModel { get }
    var confirmationDialogIsPresented: Bool { get set }
    
    func getProfileInfo()
    
    func deleteButtonTapped()
    func alertActionTapped()
  
    func confirmationDialogCancelButtonTapped()
    func confirmationDialogDeleteButtonTapped()
    
    func logoutButtonTapped()
    
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    var profileService: ProfileServiceProtocol = ProfileService()
    
    // MARK: - Public properties
    
    @Published var loadingState: LoadingState = .loading
    @Published var lifetimeId: String = .init()

    var phoneModel: PersonalInfoModel = .init(infoType: .phone)
    var emailModel: PersonalInfoModel = .init(infoType: .email)
    var status: Status = .unauthorized
    var name: String = .init()
    
    var isAuthorized: Bool {
        status == .authorized
    }
    
    var infoModels: [PersonalInfoModel] {
        [phoneModel, emailModel]
    }
    
    var alertModel = AlertModel(
        title: "Attention",
        message: "Your account has been deleted"
    )
    
    @Published var alertIsPresented: Bool = false
    
    var confirmationDialogModel = ConfirmationDialogModel()
    @Published var confirmationDialogIsPresented: Bool = false
    
    // MARK: - Public methods
    
    func getProfileInfo() {
        loadingState = .loading
        status = .unauthorized
        
        Task.detached { [weak self] in
            guard let self = self else { return }
            do {
                let profileModel = try await profileService.getProfileInfo()
                Task { @MainActor in
                    self.fillModel(with: profileModel)
                    self.loadingState = .loaded
                    self.status = .authorized
                }
            } catch {
                print("error")
            }
        }
    }
    
    func deleteButtonTapped() {
        confirmationDialogIsPresented = true
    }
    
    func logoutButtonTapped() {
        status = .unauthorized
    }
    
    func alertActionTapped() {
        alertIsPresented = false
        status = .unauthorized
    }
    
    func confirmationDialogCancelButtonTapped() {
        confirmationDialogIsPresented = false
    }
    
    func confirmationDialogDeleteButtonTapped() {
        confirmationDialogIsPresented = false
        alertIsPresented = true
    }
    
    // MARK: - Private methods
    
    private func fillModel(with data: ProfileResponseModel) {
        name = "\(data.firstName) \(data.lastName)"
        phoneModel.subtitle = data.phone.format(with: "+X XXX XX XXX XX")
        emailModel.subtitle = data.email
        lifetimeId = data.id
    }
    
    private func showAlert() {
        alertIsPresented = true
    }
    
}

 // MARK: - Status

extension ProfileViewModel {
    
    enum Status {
        case unauthorized
        case authorized
    }
    
}
