//
//  UserViewModel.swift
//  NeptisGame
//
//  Created by Harun Begic on 31. 7. 2024..
//
import SwiftUI
import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    
    func fetchUsers(completion: @escaping () -> Void = {}) {
        UserService.shared.fetchUsers { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.users = users.sorted { $0.id < $1.id }
                    completion()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func addUser(user: User) {
        if !users.contains(where: { $0.id == user.id }) {
            users.append(user)
        }
    }
}
