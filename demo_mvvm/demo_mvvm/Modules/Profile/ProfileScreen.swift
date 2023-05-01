//
//  ProfileScreen.swift
//  Demo_mvvm
//
//  Created by Артем Романов on 26.04.2023.
//

import SwiftUI

struct ProfileScreen<ViewModel>: View where ViewModel: ProfileViewModelProtocol {
    
    @StateObject var viewModel: ViewModel
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.loadingState.isLoading {
                    Loader()
                } else {
                    content
                }
            }.task {
                viewModel.getProfileInfo()
            }
            .defaultPadding()
            .navigationTitle("Profile")
        }
    }
    
    // MARK: - Content
    
    private var content: some View {
        ScrollView {
            VStack {
                if viewModel.isAuthorized {
                    authorizedView
                        .confirmationDialog(
                            "Are you sure you want to delete account?",
                            isPresented: $viewModel.confirmationDialogIsPresented) {
                                Button("Delete", role: .destructive) {
                                    viewModel.confirmationDialogDeleteButtonTapped()
                                }
                                Button("Cancel", role: .cancel) {
                                    viewModel.confirmationDialogCancelButtonTapped()
                                }
                            }
                            .alert(viewModel.alertModel.title,
                                   isPresented: $viewModel.alertIsPresented
                            ) {
                                Button(viewModel.alertModel.buttonTitle) {
                                    viewModel.alertActionTapped()
                                }
                            } message: {
                                Text(viewModel.alertModel.message)
                            }
                } else {
                    unauthorizedView
                }
            }
        }
    }
    
    // MARK: - Authorized view
    
    private var authorizedView: some View {
        VStack(alignment: .leading) {
            nameView
                .padding(.bottom, 30)
            
            personalInfoBlock
                .padding(.bottom, 100)
            
            idView
                .padding(.bottom, 100)
            
            deleteButton
        }
        .padding(.vertical)
        .padding(.horizontal, 16)
    }
    
    // MARK: - Name
    
    private var nameView: some View {
        VStack(alignment: .leading) {
            Text("Name")
                .font(.body)
                .foregroundColor(.secondary)
            
            HStack {
                Text(viewModel.name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
                
                Button {
                    viewModel.logoutButtonTapped()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.2)
                            .stroke(Color.black)
                            .frame(width: 110, height: 40)
                        Text("Logout")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
    
    // MARK: - Personal info block
    
    private var personalInfoBlock: some View {
        VStack(alignment: .leading, spacing: 30) {
            ForEach(viewModel.infoModels, id: \.self) {
                makePersonalInfoView($0)
            }
        }
    }
    
    // MARK: - Personal info view
    
    private func makePersonalInfoView(_ model: PersonalInfoModel) -> some View {
        HStack(alignment: .top, spacing: 20) {
            Image(model.iconName)
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(model.title)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                if let subtitle = model.subtitle {
                    Text(subtitle)
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    // MARK: - ID view
    
    private var idView: some View {
        HStack {
            Text("ID")
            
            Spacer()
            
            Text(viewModel.lifetimeId)
                .padding(.trailing, 10)
        }
        .font(.body)
        .foregroundColor(.secondary)
        .padding(.horizontal, 30)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .frame(height: 64)
                .shadow(
                    color: .secondary,
                    radius: 12,
                    x: 2,
                    y: 2
                )
        }
    }
    
    // MARK: - Delete button
    
    private var deleteButton: some View {
        StandardButton(text: "Delete account") {
            viewModel.deleteButtonTapped()
        }
    }
    
    // MARK: - Unauthorized view
    
    private var unauthorizedView: some View {
        VStack {
            Image("imgProfile")
                .frame(width: 186, height: 204)
                .padding(.bottom, 48)
            
            Text("This tab will display your profile information. To do this, you need to register")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(32)
    }
    
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen(viewModel: ProfileViewModel())
    }
}
